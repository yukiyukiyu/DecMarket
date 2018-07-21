package com.yuki.decmarket.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.dozer.Mapper;
import com.yuki.decmarket.controller.user.UserForm.NewUser;

import javax.validation.groups.Default;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	protected Mapper beanMapper;

	public UserForm setUpForm() {
		return new UserForm();
	}

	@RequestMapping("register")
	public String register(@Validated({NewUser.class, Default.class}) UserForm form,
	                       BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			return "index";
		}
		return "index";
	}
}
