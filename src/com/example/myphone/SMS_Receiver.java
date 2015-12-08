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

//�㲥�����߼������Ž�����Ϣ
public class SMS_Receiver extends BroadcastReceiver {
	private static final String TAG = "MyPhone";
	public final boolean DEBUG = true;
	@Override
	public void onReceive(Context context, Intent intent) 
	{
		/*�����ַ�������sb*/     
		StringBuilder sb = new StringBuilder();
		/*������Intent����������*/
		Bundle bundle = intent.getExtras();
		/*�ж�Intent��������*/
		if (bundle != null)
		{
			/* pdusΪ android���ö��Ų��� identifier
			 * ͨ��bundle.get("")����һ����pdus����
			 */    
			Object[] myOBJpdus = (Object[]) bundle.get("pdus");
			/*�������Ŷ���array,�������յ��Ķ��󳤶�������array�Ĵ�С*/       
			SmsMessage[] messages = new SmsMessage[myOBJpdus.length];
			for (int i = 0; i<myOBJpdus.length; i++) 
				messages[i] = SmsMessage.createFromPdu ((byte[]) myOBJpdus[i]);
			/* �Ѵ����Ķ��źϲ�������stringbuffer�� */   
			int nProtocol;
			long lDate;
			byte[] bAryUserData;
			String strUserData;
			for (SmsMessage currentMessage : messages)         
			{
				/* �����˵绰���� */    
				sb.append(currentMessage.getDisplayOriginatingAddress()
						+ "+");
				/* ȡ�ô�������Ϣ*/    
				sb.append(currentMessage.getDisplayMessageBody() + "+"); 
				/* ȡ�ô�����ʱ��*/  
				lDate = currentMessage.getTimestampMillis();
				sb.append(lDate + "+"); 

	            Date date=new Date(lDate);  
	            //��ʽ������Ϊ��λ������  
	            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
	            String strdate = sdf.format(date);
	            sb.append(strdate + "+");
	            
				/* ȡ�ô�������Ϣ����*/  
				nProtocol = currentMessage.getProtocolIdentifier();
				sb.append(nProtocol);
				
				if(MainActivity.objPhone != null)
				//����JNI�㷢��
				try {
					byte[] bArry = sb.toString().getBytes("gbk");
					MainActivity.objPhone.SendNewInSms(bArry, 
							bArry.length);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}        
		} 
		/* ��Log.i��ʽչʾ  */
		if(DEBUG)
            Log.i(TAG, sb.toString());
	} 
}
