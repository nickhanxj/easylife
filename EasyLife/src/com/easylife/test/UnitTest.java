package com.easylife.test;

import org.junit.Test;

import com.easylife.util.HttpRequestUtil;

public class UnitTest {
	@Test
	public void testPhone() throws Exception {
		String url = "http://apis.baidu.com/apistore/mobilephoneservice/mobilephone";
		String param = "tel=15680161252";
		String sendGet = HttpRequestUtil.sendGet(url, param, "a39b7a474370fd348817322b5bd12f00");
		System.out.println(sendGet);
	}
}
