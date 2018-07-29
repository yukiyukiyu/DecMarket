package com.yuki.decmarket.controller.user;

import com.yuki.decmarket.model.Favlists;
import com.yuki.decmarket.model.Goods;
import com.yuki.decmarket.model.UserInfo;
import com.yuki.decmarket.model.Users;
import com.yuki.decmarket.service.GoodService;
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
import com.yuki.decmarket.controller.user.UserInfoForm.editUserInfo;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.handler.UserRoleAuthorizationInterceptor;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.jws.soap.SOAPBinding;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.groups.Default;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	protected Mapper beanMapper;

	@Autowired
	protected UserService userService;

	@ModelAttribute
	public UserForm setUpUserForm() {
		return new UserForm();
	}

	@ModelAttribute
	public UserInfoForm setUpUserInfoForm() {
		return new UserInfoForm();
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
				request.getSession(true).setAttribute("is_admin", user.getPrivilege());
				request.getSession(true).setAttribute("username", user.getUsername());
				request.getSession(true).setAttribute("nickname",
						userService.getUserInfoByID(user.getId()).getNickname());
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
		request.getSession(true).removeAttribute("is_admin");
		request.getSession(true).removeAttribute("username");
		request.getSession(true).removeAttribute("nickname");
		return "redirect:/";
	}

	@RequestMapping(value = "/editPassword", method = RequestMethod.POST)
	public String editPassword(HttpServletRequest request, ModelMap modelMap, RedirectAttributes attributes) {
		int user_id = (int) request.getSession().getAttribute("user_id");
		Users user = userService.getUserByID(user_id);

		String oldpassword = request.getParameter("oldpassword");
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");

		if (!BCrypt.checkpw(oldpassword, user.getPassword()) || password.isEmpty() ||
				repassword.isEmpty() || !password.equals(repassword)) {
			modelMap.addAttribute("error", "修改信息错误！");
			attributes.addFlashAttribute("user_id", user_id);
			return "/user/editPassword";
		}

		user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
		userService.updateUser(user);
		modelMap.addAttribute("okay", "密码修改成功！");
		return "/user/editPassword";
	}

	@RequestMapping(value = "/{user_id}/profile", method = RequestMethod.GET)
	public String getProfile(@PathVariable("user_id") Integer user_id, HttpServletRequest request, ModelMap modelMap) {
		Users user = userService.getUserByID(user_id);
		UserInfo userInfo = userService.getUserInfoByID(user_id);

		if (user_id != (int) request.getSession().getAttribute("user_id"))
			modelMap.addAttribute("readOnly");

		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);

		return "/user/profile";
	}

	@RequestMapping(value = "/editUserInfo", method = RequestMethod.POST)
	public String editUserInfo(@Validated({editUserInfo.class, Default.class}) UserInfoForm form,
	                           HttpServletRequest request, ModelMap modelMap) {
		int user_id = (int) request.getSession().getAttribute("user_id");
		Users user = userService.getUserByID(user_id);

		if (!BCrypt.checkpw(request.getParameter("password"), user.getPassword())) {
			modelMap.addAttribute("error", "密码错误！");
		} else {
			UserInfo userInfo = beanMapper.map(form, UserInfo.class);
			userService.editUserInfo(userInfo);

			user.setTel(request.getParameter("tel"));
			user.setEmail(request.getParameter("email"));
			userService.updateUser(user);

			modelMap.addAttribute("okay", "修改成功！");
		}

		return "redirect:/user/" + user_id + "/profile";
	}

	@RequestMapping(value = "/getFavList", method = RequestMethod.GET)
	public String getFavList(HttpServletRequest request) {
		int user_id = (int) request.getSession().getAttribute("user_id");
		List<Favlists> favlist = userService.getFavListByID(user_id);
		List<Goods> goodsList = new ArrayList<>();
		GoodService goodService = new GoodService();
		for(Favlists it : favlist) {
			goodsList.add(goodService.getGoodByID(it.getGoodId()));
		}
		request.setAttribute("favlist", goodsList);
		return "/user/favlist";
	}
}
