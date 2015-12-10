package com.easylife.web.action;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.easylife.base.BaseAction;
import com.easylife.domain.TodayHistory;
import com.easylife.util.HttpRequestUtil;

public class ToolAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private Calendar calendar;
	private String phoneNumber;
	private String phoneSearchUrl = "http://apis.baidu.com/apistore/mobilephoneservice/mobilephone";
	private String todayhistoryUrl = "http://apis.baidu.com/netpopo/todayhistory/todayhistory";
	private String newsUrl = "http://apis.baidu.com/songshuxiansheng/news/news";
	private String newsType;//1是旅游 2是要闻 3是应用 4是游戏
	private String apikey = "a39b7a474370fd348817322b5bd12f00";

	public String phoneNumber() {
		return "phoneSearch";
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
		return "news";
	}

	public String getNews() {
		String response = HttpRequestUtil.sendGet(newsUrl, null ,apikey);
		System.out.println("r: "+response);
		putJson(response);
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

}
