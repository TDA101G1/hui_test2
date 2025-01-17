package com.customerize.websocket.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@WebServlet("/InviteEditScheduleController")
public class InviteEditSchedule extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html");
		PrintWriter outs = res.getWriter();
		String email = req.getParameter("email");
		String cust_schedule_id = req.getParameter("cust_schedule_id");
		if(email != null && email.length() != 0) {
			String host = "smtp.gmail.com";// 宣告協定為gmail格式
			int port = 587;
			final String username = "tibame101G1@gmail.com";// 自己的帳號
			final String password = "TDA101G1";// 信箱的密碼

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
//				StringBuilder redicetpath = new StringBuilder();
//				String path = req.getRequestURL().substring(0, req.getRequestURL().lastIndexOf("/"));
//				redicetpath.append(path).append("/CustomerizeController?action=produce_schedule&cust_schedule_id=").append(cust_schedule_id);
//				System.out.println("redicetpath = " + redicetpath);
				
				StringBuilder redicetpath = new StringBuilder();
				redicetpath.append(req.getServerName()).append(":").append(req.getServerPort()).append(req.getContextPath()).append("/CustomerizeController?action=produce_schedule&cust_schedule_id=").append(cust_schedule_id);
				System.out.println("redicetpath = " + redicetpath);
				
				Message message = new MimeMessage(session);
				message.setFrom(new InternetAddress(username, "Tourism")); // 自己的帳號
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email)); // 寄給誰的帳號
				message.setSubject("邀請您來共同編輯");// 信件主題
//				message.setText("Dear Levin, \n\n <a herf=#/> \\n 1231231321321測試 測試 測試 測試 測試 測試 email !", "text/html");// 信件內容
//				message.setContent("<h1>台灣第一旅遊網站 - Tourism</h1>"
//								+ "<a href='" + redicetpath.toString() +"'>立即前往編輯行程</a>", "text/html; charset=UTF-8");
				message.setContent("<h1>台灣第一旅遊網站 - Tourism</h1>"
						+ "<a href='http://"+ redicetpath.toString() +"'>立即前往編輯行程</a>", "text/html; charset=UTF-8");

				Transport transport = session.getTransport("smtp");// 協定
				transport.connect(host, port, username, password);// 建立連結存入帳密號碼跟port

				Transport.send(message);
				transport.close();
				System.out.println("寄送email結束.");
				outs.write(new JSONObject().put("result", "success").toString());

			} catch (MessagingException | JSONException e) {
				throw new RuntimeException(e);
			}
		}
		
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
