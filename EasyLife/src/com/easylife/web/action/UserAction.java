package com.easylife.web.action;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.struts2.ServletActionContext;

import com.easylife.base.BaseAction;
import com.easylife.domain.User;
import com.easylife.service.UserService;
import com.easylife.util.ImageCodeGenerator;
import com.opensymphony.xwork2.ActionContext;

public class UserAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	@Resource
	private UserService userService;
	private User user;
	private String vcode;

	public String getImageCode() {
		String random = ImageCodeGenerator.random(4);
		ImageCodeGenerator.remeberCode = random;
		UUID uuid = UUID.randomUUID();
		try {
			String realPath = ServletActionContext.getServletContext()
					.getRealPath("/images");
			File imgFolder = new File(realPath);
			File[] listFiles = imgFolder.listFiles();
			for (File file : listFiles) {
				if(file.getName().contains("imagecode")){
					File f = new File(realPath+"/imagecode");
					File[] files = f.listFiles();
					for (File img : files) {
						img.delete();
					}
				}
			}
			ImageCodeGenerator.render(random, new FileOutputStream(realPath
					+ "/imagecode/"+uuid+".jpg"), 120, 30);
		} catch (Exception e) {
			e.printStackTrace();
		}
		putJson("images/imagecode/"+uuid+".jpg");
		return JSON;
	}

	public String list() {
		return "list";
	}

	public String listData() {
		List<User> users = userService.getAllUsers();
		putJson(users);
		return JSON;
	}

	public String login() {
		user.setPassword(DigestUtils.md5Hex(user.getPassword()));
		User authUser = userService.authUser(user);
		if (authUser == null) {
			putJson("用户名或密码错误！");
			return JSON;
		}
		if (!ImageCodeGenerator.remeberCode.equals(vcode)) {
			putJson("验证码错误！");
			return JSON;
		}
		ActionContext.getContext().getSession().put("authUser", authUser);
		// 更新用户信息
		authUser.setLastLoginDate(authUser.getCurLoginDate());
		authUser.setCurLoginDate(new Date());
		authUser.setLastLoginIp(authUser.getCurLoginIp());
		HttpServletRequest request = ServletActionContext.getRequest();
		authUser.setCurLoginIp(request.getRemoteAddr());
		userService.updateUser(authUser);
		putJson("SUCCESS");
		return JSON;
	}

	public String logout() {
		ActionContext.getContext().getSession().put("authUser", null);
		return "login";
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getVcode() {
		return vcode;
	}

	public void setVcode(String vcode) {
		this.vcode = vcode;
	}

}
