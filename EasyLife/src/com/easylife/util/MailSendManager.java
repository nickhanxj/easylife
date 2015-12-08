package com.easylife.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

public class MailSendManager {
	private MimeMessage message;
	private Session session;
	private Transport transport;
    private String mailHost="";
    private String sender_username="";
    private String sender_password="";
    private Properties properties = new Properties();
    
    public MailSendManager(boolean debug) {
        InputStream in = MailSendManager.class.getResourceAsStream("/mail.properties");
        try {
            properties.load(in);
            this.mailHost = properties.getProperty("mail.smtp.host");
            this.sender_username = properties.getProperty("mail.sender.username");
            this.sender_password = properties.getProperty("mail.sender.password");
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        session = Session.getInstance(properties);
        session.setDebug(debug);//开启后有调试信息
        message = new MimeMessage(session);
    }
    
    public void doSendHtmlEmail(String subject, String sendHtml,
            List<String> receiveUser) {
        try {
            // 发件人
            //InternetAddress from = new InternetAddress(sender_username);
            // 下面这个是设置发送人的Nick name
            InternetAddress from = new InternetAddress(MimeUtility.encodeWord("personalspace.cn")+" <"+sender_username+">");
            message.setFrom(from);
            
            // 收件人
//            InternetAddress[] to = new InternetAddress(receiveUser);
//            message.setRecipient(Message.RecipientType.TO, to);//还可以有CC、BCC
            InternetAddress[] to = new InternetAddress[receiveUser.size()];
            for (int i = 0; i < receiveUser.size(); i++) {
				to[i] = new InternetAddress(receiveUser.get(i));
			}
			message.setRecipients(Message.RecipientType.TO, to);
            
            // 邮件主题
            message.setSubject(subject);
            
            String content = sendHtml.toString();
            // 邮件内容,也可以使纯文本"text/plain"
            message.setContent(content, "text/html;charset=UTF-8");
            
            // 保存邮件
            message.saveChanges();
            
            
            transport = session.getTransport("smtp");
            // smtp验证，就是你用来发邮件的邮箱用户名密码
            transport.connect(mailHost, sender_username, sender_password);
            // 发送
            transport.sendMessage(message, message.getAllRecipients());
            //System.out.println("send success!");
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(transport!=null){
                try {
                    transport.close();
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    public static void main(String[] args) {
		MailSendManager manager = new MailSendManager(true);
		List<String> receiveUser = new ArrayList<String>();
		receiveUser.add("471026023@qq.com");
//		manager.doSendHtmlEmail("test", "test", receiveUser);
	}
}
