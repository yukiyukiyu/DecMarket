package com.yuki.decmarket.controller.user;

import com.yuki.decmarket.model.Users;
import com.yuki.decmarket.service.UserService;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.dozer.Mapper;
import com.yuki.decmarket.controller.user.UserForm.NewUser;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.jws.soap.SOAPBinding;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.groups.Default;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	protected Mapper beanMapper;
	@Autowired
	protected UserService userService;

	@ModelAttribute
	public UserForm setUpForm() {
		return new UserForm();
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@Validated({NewUser.class, Default.class}) UserForm form,
	                       BindingResult result, ModelMap modelMap) {
		if (result.hasErrors()) {
			return "/user/register";
		}

		if (userService.getUserByUsername(form.getUsername()) != null) {
			modelMap.addAttribute("invalidUser", "用户名已存在！");
			return "/user/register";
		}

		if (!form.getPassword().equals(form.getRepassword())) {
			modelMap.addAttribute("diffPassword", "密码不一致！");
			return "/user/register";
		}

		Users newUser = beanMapper.map(form, Users.class);
		String bcryptPasswd = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
		newUser.setPassword(bcryptPasswd);
		newUser.setPrivilege((byte) 0);
		userService.register(newUser);
		return "redirect:/";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, ModelMap modelMap) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		Users user = userService.getUserByUsername(username);

		if (user == null) {
			modelMap.addAttribute("invalidUser", "用户名不存在！");
			return "/user/login";
		} else {
			if (BCrypt.checkpw(password, user.getPassword())) {
				request.getSession(true).setAttribute("user_id", user.getId());
				return "redirect:/";
			} else {
				modelMap.addAttribute("error", "密码错误！");
				return "/user/login";
			}
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		request.getSession(true).removeAttribute("user_id");
		return "redirect:/";
	}

	@RequestMapping(value = "/editPassword", method = RequestMethod.POST)
	public String editPassword(HttpServletRequest request, ModelMap modelMap, RedirectAttributes attributes) {
		int user_id = (int) request.getSession().getAttribute("user_id");
		Users user = userService.getUserByID(user_id);

		String oldpassword = request.getParameter("oldpassword");
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");

		if(!BCrypt.checkpw(oldpassword, user.getPassword()) || password.isEmpty() ||
				repassword.isEmpty() || !password.equals(repassword)) {
			modelMap.addAttribute("error", "修改信息错误！");
			attributes.addFlashAttribute("user_id", user_id);
			return "/user/profile";
		}

		user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
		userService.updateUser(user);

		attributes.addFlashAttribute("user_id", user_id);
		return "/user/profile";
	}
}
