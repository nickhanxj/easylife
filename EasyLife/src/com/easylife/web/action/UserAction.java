package com.easylife.web.action;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.easylife.base.BaseAction;
import com.easylife.domain.SystemTheme;
import com.easylife.domain.User;
import com.easylife.service.SystemThemeService;
import com.easylife.service.UserService;
import com.easylife.util.HttpRequestUtil;
import com.easylife.util.ImageCodeGenerator;
import com.easylife.util.MailSendManager;
import com.opensymphony.xwork2.ActionContext;

public class UserAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	@Resource
	private UserService userService;
	@Resource
	private SystemThemeService themeService;
	private Calendar calendar;
	MailSendManager sendManager = new MailSendManager(true);
	private User user;
	private String vcode;
	private String password;
	private String originPassword;
	private String userIds;

	public String getImageCode() {
		String random = ImageCodeGenerator.random(5);
		ImageCodeGenerator.remeberCode = random;
		UUID uuid = UUID.randomUUID();
		try {
			String realPath = ServletActionContext.getServletContext()
					.getRealPath("/images");
			File imgFolder = new File(realPath);
			File[] listFiles = imgFolder.listFiles();
			for (File file : listFiles) {
				if (file.getName().contains("imagecode")) {
					File f = new File(realPath + "/imagecode");
					File[] files = f.listFiles();
					for (File img : files) {
						img.delete();
					}
				}
			}
			ImageCodeGenerator.render(random, new FileOutputStream(realPath
					+ "/imagecode/" + uuid + ".jpg"), 120, 30);
		} catch (Exception e) {
			e.printStackTrace();
		}
		putJson("images/imagecode/" + uuid + ".jpg");
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

	public String addUser() {
		if (StringUtils.isBlank(user.getUserName())
				|| StringUtils.isBlank(user.getPassword())) {
			putJson("用户名或者密码不能为空！");
			return JSON;
		} else {
			boolean hasExist = userService.hasExist(user.getUserName());
			boolean trueNameHasExist = userService.trueNameHasExist(user
					.getTrueName());
			if (hasExist) {
				putJson("该用户名已存在，请使用其他用户名！");
				return JSON;
			} else if (trueNameHasExist) {
				putJson("该真实姓名已经注册过！");
				return JSON;
			} else {
				try {
					user.setRegisterDate(new Date());
					String md5Hex = DigestUtils.md5Hex(user.getPassword());
					user.setPassword(md5Hex);
					userService.addUser(user);
					putJson("添加成功");
					addLog(getSessionUser().getUserName(),"添加用户","成功",null);
				} catch (Exception e) {
					e.printStackTrace();
					putJson("添加失败！");
					addLog(getSessionUser().getUserName(),"添加除用户","失败",e.getMessage());
					return JSON;
				}
			}
		}
		return JSON;
	}

	public String deleteUser() {
		String[] ids = userIds.split(",");
		try {
			for (String userId : ids) {
				User u = new User();
				u.setId(Long.valueOf(userId));
				userService.deleteUser(u);
			}
			addLog(getSessionUser().getUserName(),"删除用户","成功",null);
			putJson("删除成功");
		} catch (Exception e) {
			addLog(getSessionUser().getUserName(),"删除用户","失败",e.getMessage());
			putJson("删除失败");
		}
		return JSON;
	}
	
	public String sendEmail(){
		try {
			String[] ids = userIds.split(",");
			List<User> selectedUsers = new ArrayList<User>();
			for (String id : ids) {
				User u = userService.getUserByid(id);
				selectedUsers.add(u);
			}
			sendEmailToUser(selectedUsers);
			putJson("邮件发送成功");
		} catch (Exception e) {
			putJson("邮件发送失败");
		}
		return JSON;
	}
	
	private void sendEmailToUser(List<User> selectedUsers) throws Exception{
		calendar = Calendar.getInstance();
		String year = String.valueOf(calendar.get(Calendar.YEAR));
		String month = String.valueOf(calendar.get(Calendar.MONTH)+1);
		List<String> receiveUser = new ArrayList<String>();
		for (User user : selectedUsers) {
			receiveUser.add(user.getEmail());
		}
		String url = "http://localhost/cost/statisticsForEmail.html";
		String param = "year="+year+"&month="+month;
		String sendHtml = HttpRequestUtil.sendGet(url, param, null);
		System.out.println(sendHtml);
		sendManager.doSendHtmlEmail(year+"年"+month+"月消费账单", sendHtml, receiveUser);
	}

	public String login() {
		user.setPassword(DigestUtils.md5Hex(user.getPassword()));
		User authUser = userService.authUser(user);
		if (authUser == null) {
			putJson("用户名或密码错误！");
			if(StringUtils.isNotBlank(user.getUserName())){
				addLog(user.getUserName(),"帐号登录","失败","用户名或密码错误！");
			}
			return JSON;
		}
		if (!ImageCodeGenerator.remeberCode.equals(vcode)) {
			putJson("验证码错误！");
			addLog(authUser.getUserName(),"帐号登录","失败","验证码错误！");
			return JSON;
		}
		if(authUser.getType() == 1){
			putJson("您的帐号非管理员帐号，不能登录后台系统。");
			addLog(authUser.getUserName(),"帐号登录","失败","非管理员帐号");
			return JSON;
		}
		if(authUser.getStatus() == 0){
			putJson("帐号异常，请联系管理员。");
			addLog(authUser.getUserName(),"帐号登录","失败","帐号异常");
			return JSON;
		}
		//获取用户使用的主题
		SystemTheme theme = themeService.findByUserId(authUser.getId());
		if(theme != null){
			ActionContext.getContext().getSession().put("systemTheme", theme.getTheme());
		}else{
			ActionContext.getContext().getSession().put("systemTheme", "ui-cupertino");
		}
		ActionContext.getContext().getSession().put("authUser", authUser);
		// 更新用户信息
		authUser.setLastLoginDate(authUser.getCurLoginDate());
		authUser.setCurLoginDate(new Date());
		authUser.setLastLoginIp(authUser.getCurLoginIp());
		HttpServletRequest request = ServletActionContext.getRequest();
		authUser.setCurLoginIp(request.getRemoteAddr());
		userService.updateUser(authUser);
		addLog(authUser.getUserName(),"帐号登录","成功",null);
		putJson("SUCCESS");
		return JSON;
	}

	public String userInfo() {
		User auser = (User) ActionContext.getContext().getSession()
				.get("authUser");
		User selectedUser = userService.getUserByid(auser.getId() + "");
		ActionContext.getContext().put("selectedUser", selectedUser);
		return "userinfo";
	}

	// 登录后修改密码
	public String resetPwd() {
		User sessionUser = getSessionUser();
		String newPassword = DigestUtils.md5Hex(password);
		sessionUser.setPassword(newPassword);
		try {
			userService.updateUser(sessionUser);
			putJson(STATUS_SUCCESS);
			ActionContext.getContext().getSession().put("authUser", null);
		} catch (Exception e) {
			e.printStackTrace();
			putJson(STATUS_ERROR);
		}
		return JSON;
	}

	public String validateOriginPasswd() {
		User sessionUser = getSessionUser();
		String originPasswordMd5 = DigestUtils.md5Hex(originPassword);
		if (originPasswordMd5.equals(sessionUser.getPassword())) {
			putJson(STATUS_SUCCESS);
		} else {
			putJson(STATUS_ERROR);
		}
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getOriginPassword() {
		return originPassword;
	}

	public void setOriginPassword(String originPassword) {
		this.originPassword = originPassword;
	}

	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}

}
