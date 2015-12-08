package com.example.myphone;


import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.provider.ContactsContract;
import android.telephony.TelephonyManager;
import android.util.Log;

//ͨ���㲥
public class VOICE_Receiver extends BroadcastReceiver{
	private static final String TAG = "MyPhone";
	private static boolean DEBUG = true;
    private static boolean incomingFlag = false;  
    private static String phonenumber = null;  
    
    public String GetPersonName(String phoneNumber)
    {
    	return "null";
    }

    public String QueryNameFromNumber(String num)
    {
    	Cursor cursor = null;
    	try
    	{
			if(DEBUG)
				Log.i(TAG, "PhoneInfo::QueryNameFromNumber");
			String[] projection = new String[] {"data1", "display_name"};
			String[] selectionArgs = new String[] {num.toString()};
    		//��ѯ��ϵ������
    		cursor = MainActivity.MainThis.getContentResolver().query(
    				ContactsContract.CommonDataKinds.Phone.CONTENT_URI, 
    				projection, " data1 = ?", selectionArgs, null);
    		while(cursor.moveToNext())
    		{
    			//��ȡ��ϵ������
    			String displayName = cursor.getString(
    					cursor.getColumnIndex("display_name"));
    			return displayName;
    		}

    	} catch(Exception e)
    	{
    		//e.printStackTrace();
    	}
    	return "null";
    }
  @Override    
  public void onReceive(Context context, Intent intent) 
  {
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	  Date curDate = new Date(System.currentTimeMillis());
	  String strdate = sdf.format(curDate);
	  StringBuilder sb = new StringBuilder();
      //����ǲ���绰    
      if(intent.getAction().equals(Intent.ACTION_NEW_OUTGOING_CALL))
      {                           
          incomingFlag = false;  
          phonenumber = intent.getStringExtra(Intent.EXTRA_PHONE_NUMBER);
          sb.append(strdate + "+");
          sb.append(2 + "+");
          sb.append(phonenumber + "+");
          sb.append(QueryNameFromNumber(phonenumber));
          //sb.append(GetPersonName(phonenumber));
          if (DEBUG)
        	  Log.i(TAG, "��ȥ�磺" + sb);
          if(MainActivity.objPhone != null)
          {
            //����JNI�㷢��
  			try {
  				byte[] bArry = sb.toString().getBytes("gbk");
  				MainActivity.objPhone.SendNewVoiceMsg(bArry, 
  						bArry.length);
  			} catch (UnsupportedEncodingException e) {
  				e.printStackTrace();
  			}
          }
      }            
      //���������    
      else
      {               
          TelephonyManager tm =    
              (TelephonyManager)context.getSystemService
              (Service.TELEPHONY_SERVICE);                         

          switch (tm.getCallState()) 
          {    
          case TelephonyManager.CALL_STATE_RINGING:    
                  incomingFlag = true;//��ʶ��ǰ������    
                  phonenumber = intent.getStringExtra("incoming_number");   
                  break;    
                  //�ӵ绰
          case TelephonyManager.CALL_STATE_OFFHOOK:                                   
                  if(incomingFlag)
                  {
                      sb.append(strdate + "+");
                      sb.append(1 + "+");
                      sb.append(phonenumber + "+");
                      sb.append(QueryNameFromNumber(phonenumber));
                      //sb.append(GetPersonName(phonenumber));
                      if (DEBUG)
                    	  Log.i("TAG", "�����磺" + sb);
                      if(MainActivity.objPhone != null)
                      {
                        //����JNI�㷢��
              			try {
              				byte[] bArry = sb.toString().getBytes("gbk");
              				MainActivity.objPhone.SendNewVoiceMsg(bArry, 
              						bArry.length);
              			} catch (UnsupportedEncodingException e) {
              				e.printStackTrace();
              			}
                      }
                  }    
                  break;    
          case TelephonyManager.CALL_STATE_IDLE:                                   
                  if(incomingFlag)
                  {}    
                  break;    
          }    
      }
	}    
}  

