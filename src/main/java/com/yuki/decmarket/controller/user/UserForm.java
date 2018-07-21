package com.yuki.decmarket.controller.user;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import javax.validation.constraints.Size;

public class UserForm {
	public static interface NewUser {
	}

	public static interface EditUser {
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

	public String getRepassword() {
		return repassword;
	}

	public void setRepassword(String repassword) {
		this.repassword = repassword;
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

	@NotNull(groups = NewUser.class)
	@Null(groups = EditUser.class)
	@Size(min = 1, max = 25)
	private String username;

	@NotNull
	@Size.List({@Size(min = 1, max = 50, groups = NewUser.class),
			@Size(min = 0, max = 50, groups = EditUser.class)})
	private String password;

	@NotNull
	@Size.List({@Size(min = 1, max = 25, groups = NewUser.class),
			@Size(min = 0, max = 50, groups = EditUser.class)})
	private String repassword;

	@NotNull
	private String tel;

	@NotNull
	@Email
	private String email;
}
