package com.easylife.web.action;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.easylife.base.BaseAction;
import com.easylife.domain.SystemLog;
import com.easylife.domain.SystemTheme;
import com.easylife.domain.tools.TodayHistory;
import com.easylife.service.SystemThemeService;
import com.easylife.util.HttpRequestUtil;
import com.easylife.util.Page;

public class ToolAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private Calendar calendar;
	private String phoneNumber;
	private String phoneSearchUrl = "http://apis.baidu.com/apistore/mobilephoneservice/mobilephone";
	private String todayhistoryUrl = "http://apis.baidu.com/netpopo/todayhistory/todayhistory";
	private String newsUrl = "http://apis.baidu.com/songshuxiansheng/news/news";
	private String newsType;// 1是旅游 2是要闻 3是应用 4是游戏
	private String apikey = "a39b7a474370fd3|48817322b5bd12f00";
	@Resource
	private SystemThemeService themeService;
	private SystemTheme systemTheme;
	private int page;
	private int rows;
	private String operation;

	public String log() {
		return "sysLog";
	}

	public String sysLog() {
		Map<String, String> params = new HashMap<String, String>();
		params.put("operation", operation);
		Page<SystemLog> logs = logService.getLogs(page, rows, params);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("total", logs.getTotalRow());
		for (SystemLog log : logs.getRows()) {
			if("成功".equals(log.getOperationResult())){
				log.setOperationResult("<font color='green'>成功</font>");
			}else{
				log.setOperationResult("<font color='red'>失败</font>");
			}
		}
		data.put("rows", logs.getRows());
		putJson(data);
		return JSON;
	}

	public String changeTheme() {
		try {
			SystemTheme theme = themeService.findByUserId(getSessionUser()
					.getId());
			if (theme == null) {
				systemTheme.setUserId(getSessionUser().getId());
				themeService.addTheme(systemTheme);
			} else {
				theme.setTheme(systemTheme.getTheme());
				themeService.updateTheme(theme);
			}
			putJson("更换主题成功，下次登录生效！");
			addLog(getSessionUser().getUserName(),
					"更换系统主题为【" + systemTheme.getTheme() + "】", "成功", null);
		} catch (Exception e) {
			putJson("更换主题失败");
			addLog(getSessionUser().getUserName(),
					"更换系统主题为【" + systemTheme.getTheme() + "】", "失败",
					e.getMessage());
		}
		return JSON;
	}

	public String systemSettings() {
		SystemTheme theme = themeService.findByUserId(getSessionUser().getId());
		if (theme == null) {
			putContext("sysTheme", "'ui-cupertino'");
		} else {
			putContext("sysTheme", "'" + theme.getTheme() + "'");
		}
		return "sysSettings";
	}

	public String index() {
		return "index";
	}

	public String phoneNumber() {
		return "phoneSearch";
	}

	public String baidu() {
		return "baidu";
	}

	public String sina() {
		return "sina";
	}

	public String searchPhoneNumber() {
		String param = "tel=" + phoneNumber;
		String response = HttpRequestUtil
				.sendGet(phoneSearchUrl, param, apikey);
		putJson(response);
		return JSON;
	}

	public String todayhistory() {
		calendar = Calendar.getInstance();
		String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
		String date = String.valueOf(calendar.get(Calendar.DATE));
		String param = "month=" + month + "&day=" + date
				+ "&appkey=1307ee261de8bbcf83830de89caae73f";
		String response = HttpRequestUtil.sendGet(todayhistoryUrl, param,
				apikey);
		Map<String, Class> classMap = new HashMap<String, Class>();
		classMap.put("data", TodayHistory.class);
		Map map = (Map) JSONObject.toBean(JSONObject.fromObject(response),
				Map.class, classMap);
		System.out.println(map);
		if ("0".equals(String.valueOf(map.get("error")))) {
			putContext("history", map.get("data"));
		}
		return "todayhistory";
	}

	public String news() {
		String response = HttpRequestUtil.sendGet(newsUrl, null, apikey);
		Map<String, Class> classMap = new HashMap<String, Class>();
		classMap.put("retData", Map.class);
		Map map = (Map) JSONObject.toBean(JSONObject.fromObject(response),
				Map.class, classMap);
		if ("0".equals(String.valueOf(map.get("errNum")))) {
			putContext("news", map.get("retData"));
		}
		return "news";
	}

	public String getNews() {
		return JSON;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getNewsType() {
		return newsType;
	}

	public void setNewsType(String newsType) {
		this.newsType = newsType;
	}

	public SystemTheme getSystemTheme() {
		return systemTheme;
	}

	public void setSystemTheme(SystemTheme systemTheme) {
		this.systemTheme = systemTheme;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

}
