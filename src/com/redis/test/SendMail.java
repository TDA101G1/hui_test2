package com.redis.test;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
	public Boolean sendMail(String receiver, String title, String message) {
		Boolean result = false;
		String host = "smtp.gmail.com";
		int port = 587;
		final String username = "qqqp15601560@gmail.com";//自己的帳號
		final String password = "taehee520";//信箱的密碼
		
		Properties props = new Properties();
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.auth", "true");
		  props.put("mail.smtp.starttls.enable", "true");
		  props.put("mail.smtp.port", port);
		  Session session = Session.getInstance(props, new Authenticator() {
		   protected PasswordAuthentication getPasswordAuthentication() {
		    return new PasswordAuthentication(username, password);
		   }
		  });
		  
		  try {

			   Message newMessage = new MimeMessage(session);
			   newMessage.setFrom(new InternetAddress("qqqp15601560@gmail.com")); //自己的帳號
			   newMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiver)); //寄給誰的帳號
			   newMessage.setSubject(title);//信件主題
			   newMessage.setText(message);//信件內容

			   Transport transport = session.getTransport("smtp");//協定
			   transport.connect(host, port, username, password);//建立連結存入帳密號碼跟port

			   Transport.send(newMessage);

			   System.out.println("寄送email結束.");
			   result = true;
			   return result;

			  } catch (MessagingException e) {
				  
				  e.printStackTrace();
				  return result;
			  }
	}
	
//	public static void main(String[] args) {
//		SendMail test = new SendMail();
//		System.out.println(test.sendMail("forbiail@gmail.com", "test", "test123"));
//
//	}
}
