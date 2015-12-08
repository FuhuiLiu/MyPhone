package com.example.myphone;

import java.net.InetAddress;
import java.net.UnknownHostException;

import android.app.Activity;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.StrictMode;
import android.telephony.TelephonyManager;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.Toast;

public class MainActivity extends Activity {
	public static MainActivity MainThis;  //±£¥ÊContext
	public static CPhone objPhone = null;
	public SmsObserver sbs;
	Button btnStart = null;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		MainThis = this;
		sbs = new SmsObserver(new Handler());
		getContentResolver().registerContentObserver(
				Uri.parse("content://sms"), 
				true, sbs);
		CPhone.foo();

		btnStart = (Button)findViewById(R.id.btnStart);
		
		btnStart.setOnClickListener(new OnClickListener(){

			@Override
			public void onClick(View v) {
				objPhone = new CPhone();
				objPhone.Start(); 
			}});
	}
	
	@Override
	protected void onDestroy() {
		super.onDestroy();
		getContentResolver().unregisterContentObserver(sbs);
	}

	static public MainActivity GetInstance()
	{
		return MainThis;
	}
	public void SayHello()
	{
		System.out.println("SayHello");
	}
	
	public void GetInfo()
	{
		PhoneInfo siminfo = new PhoneInfo();  
		System.out.println("getProvidersName:"+siminfo.getProvidersName());  
		System.out.println("getNativePhoneNumber:"+siminfo.getNativePhoneNumber());  
		System.out.println("------------------------");  
		System.out.println("getPhoneInfo:"+siminfo.getPhoneInfo());
	
		System.out.println("Phone Model: " + siminfo.getModel() + " Version:" + siminfo.getVersion()); 
	}
	public void GetIpAddr()
	{
			InetAddress ia;
			try {
				ia = InetAddress.getLocalHost();
				String ip = ia.getHostAddress();
				System.out.println(ip);
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}
	}
}
