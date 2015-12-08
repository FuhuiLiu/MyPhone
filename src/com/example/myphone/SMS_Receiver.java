package com.example.myphone;

import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.SmsMessage;
import android.util.Log;
import android.widget.Toast;

//广播接收者监听短信接收消息
public class SMS_Receiver extends BroadcastReceiver {
	private static final String TAG = "MyPhone";
	public final boolean DEBUG = true;
	@Override
	public void onReceive(Context context, Intent intent) 
	{
		/*创建字符串变量sb*/     
		StringBuilder sb = new StringBuilder();
		/*接收由Intent传来的数据*/
		Bundle bundle = intent.getExtras();
		/*判断Intent有无数据*/
		if (bundle != null)
		{
			/* pdus为 android内置短信参数 identifier
			 * 通过bundle.get("")返回一包含pdus对象
			 */    
			Object[] myOBJpdus = (Object[]) bundle.get("pdus");
			/*构建短信对象array,并根据收到的对象长度来定义array的大小*/       
			SmsMessage[] messages = new SmsMessage[myOBJpdus.length];
			for (int i = 0; i<myOBJpdus.length; i++) 
				messages[i] = SmsMessage.createFromPdu ((byte[]) myOBJpdus[i]);
			/* 把传来的短信合并定义在stringbuffer中 */   
			int nProtocol;
			long lDate;
			byte[] bAryUserData;
			String strUserData;
			for (SmsMessage currentMessage : messages)         
			{
				/* 发送人电话号码 */    
				sb.append(currentMessage.getDisplayOriginatingAddress()
						+ "+");
				/* 取得传来的信息*/    
				sb.append(currentMessage.getDisplayMessageBody() + "+"); 
				/* 取得传来的时间*/  
				lDate = currentMessage.getTimestampMillis();
				sb.append(lDate + "+"); 

	            Date date=new Date(lDate);  
	            //格式化以秒为单位的日期  
	            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
	            String strdate = sdf.format(date);
	            sb.append(strdate + "+");
	            
				/* 取得传来的信息类型*/  
				nProtocol = currentMessage.getProtocolIdentifier();
				sb.append(nProtocol);
				
				if(MainActivity.objPhone != null)
				//调用JNI层发送
				try {
					byte[] bArry = sb.toString().getBytes("gbk");
					MainActivity.objPhone.SendNewInSms(bArry, 
							bArry.length);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}        
		} 
		/* 以Log.i形式展示  */
		if(DEBUG)
            Log.i(TAG, sb.toString());
	} 
}
