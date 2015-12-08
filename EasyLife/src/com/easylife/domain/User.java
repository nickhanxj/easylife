package com.easylife.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_user")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false, unique = true)
	private long id;
	private String userName;
	private String trueName;
	private String password;
	private String email;
	private String phoneNumber;
	private int sex;// 0:δ֪ 1���� 2��Ů
	private int status = 1;// 0:�쳣 1����
	private Date registerDate;
	private Date lastLoginDate;
	private String lastLoginIp;
	private Date curLoginDate;
	private String curLoginIp;
	private int type = 1;// 0: ����Ա 1����ͨ�û�
	private String friends;// 好友id 用逗号隔开

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public Date getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public Date getCurLoginDate() {
		return curLoginDate;
	}

	public void setCurLoginDate(Date curLoginDate) {
		this.curLoginDate = curLoginDate;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getLastLoginIp() {
		return lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}

	public String getCurLoginIp() {
		return curLoginIp;
	}

	public void setCurLoginIp(String curLoginIp) {
		this.curLoginIp = curLoginIp;
	}

	public String getFriends() {
		return friends;
	}

	public void setFriends(String friends) {
		this.friends = friends;
	}

	public String getTrueName() {
		return trueName;
	}

	public void setTrueName(String trueName) {
		this.trueName = trueName;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", password="
				+ password + ", email=" + email + ", phoneNumber="
				+ phoneNumber + ", sex=" + sex + ", status=" + status
				+ ", registerDate=" + registerDate + ", lastLoginDate="
				+ lastLoginDate + ", lastLoginIp=" + lastLoginIp
				+ ", curLoginDate=" + curLoginDate + ", curLoginIp="
				+ curLoginIp + ", type=" + type + ", friends=" + friends + "]";
	}

}
