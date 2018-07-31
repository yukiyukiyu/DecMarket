package com.yuki.decmarket.model;

import java.util.Date;

public class Users {

    private Integer id;

    private Byte privilege;

    private String username;

    private String password;

    private String tel;

    private String email;

    private Boolean havecheckedemail;

    private Boolean baned;

    private Date created_at;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Byte getPrivilege() {
		return privilege;
	}

	public void setPrivilege(Byte privilege) {
		this.privilege = privilege;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Boolean getHavecheckedemail() {
		return havecheckedemail;
	}

	public void setHavecheckedemail(Boolean havecheckedemail) {
		this.havecheckedemail = havecheckedemail;
	}

	public Boolean getBaned() {
		return baned;
	}

	public void setBaned(Boolean baned) {
		this.baned = baned;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
}