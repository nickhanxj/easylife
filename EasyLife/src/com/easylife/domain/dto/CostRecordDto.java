package com.easylife.domain.dto;

public class CostRecordDto {
	private Integer id;
	private String user;// 消费人
	private float cost;// 消费金额
	private String costFor;// 消费项
	private String costdate;// 消费时间
	private String mark;// 备注
	private String status;// 状态 0未结 1已结
	private String attachment;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public float getCost() {
		return cost;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public void setCost(float cost) {
		this.cost = cost;
	}

	public String getCostFor() {
		return costFor;
	}

	public void setCostFor(String costFor) {
		this.costFor = costFor;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getCostdate() {
		return costdate;
	}

	public void setCostdate(String costdate) {
		this.costdate = costdate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

}
