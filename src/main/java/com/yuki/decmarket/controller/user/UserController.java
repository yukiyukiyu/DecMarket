package com.yuki.decmarket.controller.user;

import com.yuki.decmarket.model.*;
import com.yuki.decmarket.service.GoodService;
import com.yuki.decmarket.service.UserService;
import com.yuki.decmarket.util.AvatarHelper;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.dozer.Mapper;
import com.yuki.decmarket.controller.user.UserForm.NewUser;
import com.yuki.decmarket.controller.user.UserInfoForm.editUserInfo;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
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

    @Autowired
    protected GoodService goodService;

    @ModelAttribute
    public UserForm setUpUserForm() {
        return new UserForm();
    }

    @ModelAttribute
    public UserInfoForm setUpUserInfoForm() {
        return new UserInfoForm();
    }

    @RequestMapping(value = "/registerForm", method = RequestMethod.GET)
    public String registerForm() {
        return "/user/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(@Validated({NewUser.class, Default.class}) UserForm form,
                           BindingResult result, ModelMap modelMap) {
        modelMap.addAttribute("oldInput", form);

        if (result.hasErrors()) {
            return "/user/register";
        }

        if (userService.getUserByUsername(form.getUsername()) != null) {
            modelMap.addAttribute("invalidUser", "用户名已存在！");
            return "/user/register";
        }

        if (userService.getUserByInfo(form.getTel(), 1) != null) {
            modelMap.addAttribute("invalidTel", "该手机号已注册！");
            return "/user/register";
        }
        if (userService.getUserByInfo(form.getEmail(), 2) != null) {
            modelMap.addAttribute("invalidEmail", "该邮箱已注册！");
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
        newUser.setBaned(false);
        userService.register(newUser);
        modelMap.addAttribute("registerOK", "注册成功，请登录。");
        return "redirect:/user/loginForm";
    }

    @RequestMapping(value = "/loginForm", method = RequestMethod.GET)
    public String loginForm() {
        return "/user/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(HttpServletRequest request, ModelMap modelMap) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Users user = userService.getUserByUsername(username);

        if (user == null) {
            modelMap.addAttribute("invalidUser", "用户名不存在！");
            return "/user/login";
        } else if (user.getBaned() != null && user.getBaned()) {
            modelMap.addAttribute("banedUser",
                    "您的账号由于违规操作已被封禁！");
            return "/user/login";
        } else {
            if (BCrypt.checkpw(password, user.getPassword())) {
                request.getSession(true).setAttribute("user_id", user.getId());
                request.getSession(true).setAttribute("is_admin", user.getPrivilege());
                request.getSession(true).setAttribute("username", user.getUsername());

                if (userService.getUserInfoByID(user.getId()) != null)
                    request.getSession(true).setAttribute("nickname",
                            userService.getUserInfoByID(user.getId()).getNickname());

                return "redirect:/good";
            } else {
                modelMap.addAttribute("passwdError", "密码错误！");
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
            return "/user/userInfo";
        }

        user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
        userService.updateUser(user);
        modelMap.addAttribute("okay", "密码修改成功！");

        request.getSession(true).removeAttribute("user_id");
        request.getSession(true).removeAttribute("is_admin");
        request.getSession(true).removeAttribute("username");
        request.getSession(true).removeAttribute("nickname");
        return "redirect:/user/loginForm";
    }

    @RequestMapping(value = "/{user_id}/profile", method = RequestMethod.GET)
    public String getProfile(@PathVariable("user_id") int user_id, HttpServletRequest request, ModelMap modelMap) {
        if (request.getSession().getAttribute("user_id") != null &&
                (int) request.getSession().getAttribute("user_id") == user_id) {
            return "redirect:/user/userInfo";
        }

        Users user = userService.getUserByID(user_id);
        UserInfo userInfo = userService.getUserInfoByID(user_id);

        request.setAttribute("user", user);
        request.setAttribute("userInfo", userInfo);

        List<Goods> goods = goodService.getGoodByUserID(user_id);
        request.setAttribute("goods", goods);

        return "/user/profile";
    }

    @RequestMapping(value = "/createUserInfo", method = RequestMethod.POST)
    public String createUserInfo(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        UserInfo userInfo = new UserInfo();
        userInfo.setUser_id(user_id);
        userInfo.setNickname(request.getParameter("nickname"));
        userInfo.setQQ(request.getParameter("QQ"));
        userInfo.setWechat(request.getParameter("wechat"));
        userInfo.setAddress(request.getParameter("address"));
        userInfo.setIntro(request.getParameter("intro"));
        userService.createUserInfo(userInfo);
        return "redirect:/user/userInfo";
    }

    @RequestMapping(value = "/userInfo", method = RequestMethod.GET)
    public String getUserInfo(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        Users user = userService.getUserByID(user_id);
        request.setAttribute("user", user);
        UserInfo userInfo = userService.getUserInfoByID(user_id);
        request.setAttribute("userInfo", userInfo);
        return "/user/userInfo";
    }

    @RequestMapping(value = "/editUserInfoForm", method = RequestMethod.GET)
    public String editUserInfoForm(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        UserInfo userInfo = userService.getUserInfoByID(user_id);
        request.setAttribute("userInfo", userInfo);
        return "/user/editUserInfo";
    }

    @RequestMapping(value = "/editUserInfo", method = RequestMethod.POST)
    public String editUserInfo(@Validated({editUserInfo.class, Default.class}) UserInfoForm form,
                               HttpServletRequest request, ModelMap modelMap) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        Users user = userService.getUserByID(user_id);

        if (!BCrypt.checkpw(request.getParameter("password"), user.getPassword())) {
            modelMap.addAttribute("error", "密码错误！");
        } else {
            UserInfo oldUserInfo = userService.getUserInfoByID(user_id);
            UserInfo userInfo = beanMapper.map(form, UserInfo.class);
            System.out.println(userInfo.getQQ());
            userInfo.setId(oldUserInfo.getId());
            userInfo.setUser_id(user_id);
            System.out.println(userInfo.getAddress());
            userService.editUserInfo(userInfo);

            request.getSession().setAttribute("nickname", userInfo.getNickname());

            modelMap.addAttribute("okay", "修改成功！");
        }

        return "redirect:/user/" + user_id + "/profile";
    }

    @RequestMapping(value = "/delUserInfo", method = RequestMethod.POST)
    public String delUserInfo(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        UserInfo userInfo = userService.getUserInfoByID(user_id);
        userService.delUserInfoByID(userInfo.getId());
        return "redirect:/user/userInfo";
    }

    @RequestMapping(value = "/trans", method = RequestMethod.GET)
    public String getMyTrans(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        List<Transactions> trans = userService.getTransByBuyerID(user_id);

        if (trans == null) return "/user/trans";

        List<Transactions> buyedTrans = new ArrayList<>();
        List<Goods> goods = new ArrayList<>();
        for (Transactions it : trans) {
            if (it.getStatus() == 1) {
                buyedTrans.add(it);
                goods.add(goodService.getGoodByID(it.getGood_id()));
            }
        }
        request.setAttribute("trans", buyedTrans);
        request.setAttribute("goods", goods);
        return "/user/trans";
    }

    @RequestMapping(value = "/trolley", method = RequestMethod.GET)
    public String getTrolley(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        List<Transactions> trans = userService.getTransByBuyerID(user_id);

        if (trans == null) return "/user/trans";

        List<Transactions> troTrans = new ArrayList<>();
        List<Goods> goods = new ArrayList<>();
        for (Transactions it : trans) {
            if (it.getStatus() == 2) {
                troTrans.add(it);
                goods.add(goodService.getGoodByID(it.getGood_id()));
            }
        }
        request.setAttribute("trans", troTrans);
        request.setAttribute("goods", goods);
        return "/user/trolley";
    }

    @RequestMapping(value = "/{tran_id}/pay", method = RequestMethod.POST)
    public String payTrolley(@PathVariable("tran_id") int tran_id) {
        Transactions tran = userService.getTranByID(tran_id);
        tran.setStatus((short) 1);
        userService.updateTran(tran);

        Goods good = goodService.getGoodByID(tran.getGood_id());
        good.setCount(good.getCount() - tran.getNumber());
        goodService.updateGood(good);
        return "redirect:/user/trans";
    }

    @RequestMapping(value = "/{tran_id}/delTrolley", method = RequestMethod.POST)
    public String delTrolley(@PathVariable("tran_id") int tran_id) {
        Transactions tran = userService.getTranByID(tran_id);
        tran.setStatus((short) 0);
        userService.updateTran(tran);
        return "redirect:/user/trolley";
    }

    @RequestMapping(value = "/{tran_id}/comment", method = RequestMethod.POST)
    public String addTranComment(@PathVariable("tran_id") int tran_id,
                                 HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        Transactions tran = userService.getTranByID(tran_id);
        tran.setReason(request.getParameter("comment"));
        userService.addTranComment(tran);
        return "redirect:/user/trans";
    }

    @RequestMapping(value = "/{tran_id}/delComment", method = RequestMethod.POST)
    public String delTranComment(@PathVariable("tran_id") int tran_id,
                                 HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        userService.delTranComment(tran_id);
        return "redirect:/user/trans";
    }

    @RequestMapping(value = "/{user_id}/sell", method = RequestMethod.GET)
    public String getMySells(@PathVariable("user_id") int user_id, HttpServletRequest request) {
        List<Goods> goods = goodService.getGoodByUserID(user_id);
        request.setAttribute("goods", goods);
        return "user/sell";
    }

    @RequestMapping(value = "/getFavList", method = RequestMethod.GET)
    public String getFavList(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        List<Favlists> favList = userService.getFavListByID(user_id);
        List<Goods> goodsList = new ArrayList<>();
        for (Favlists it : favList) {
            if (goodService.getGoodByID(it.getGood_id()).getDeleted_at() != null)
                continue;
            goodsList.add(goodService.getGoodByID(it.getGood_id()));
        }
        request.setAttribute("favList", goodsList);
        return "/user/favList";
    }

    @RequestMapping(value = "/delFavList", method = RequestMethod.POST)
    public String delFavList(@RequestParam(value = "del_goods", required = false) String del_goods,
                             HttpServletRequest request) {
        if (del_goods == null) return "redirect:/user/getFavList";
        int user_id = (int) request.getSession().getAttribute("user_id");
        String del_goodsID[] = del_goods.split(",");
        List<Favlists> favlists = userService.getFavListByID(user_id);
        for (int i = 0; i < del_goodsID.length; i++) {
            System.out.println(del_goodsID[i]);
            if (del_goodsID[i].equals("0"))
                continue;
            for (Favlists it : favlists) {
                if (it.getGood_id() == Integer.parseInt(del_goodsID[i])) {
                    userService.delFavListByID(it.getId());
                }
            }
        }
        return "redirect:/user/getFavList";
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(HttpServletRequest request) {
        List<Users> usersList = userService.getUserList();
        for (Users user : usersList) {
            System.out.println(user.getId());
        }
        request.setAttribute("users", usersList);
        List<Transactions> transactionsList = userService.getTransList();
        request.setAttribute("trans", transactionsList);
        return "/user/admin";
    }

    @RequestMapping(value = "/{user_id}/setAdmin", method = RequestMethod.POST)
    public String setAdmin(@PathVariable("user_id") int user_id) {
        Users user = userService.getUserByID(user_id);
        user.setPrivilege((byte) 1);
        userService.updateUser(user);
        return "redirect:/user/" + user_id + "/profile";
    }

    @RequestMapping(value = "/{user_id}/removeAdmin", method = RequestMethod.POST)
    public String removeAdmin(@PathVariable("user_id") int user_id) {
        Users user = userService.getUserByID(user_id);
        user.setPrivilege((byte) 0);
        userService.updateUser(user);
        return "redirect:/user/" + user_id + "/profile";
    }

    @RequestMapping(value = "/{user_id}/ban", method = RequestMethod.POST)
    public String banUser(@PathVariable("user_id") int user_id) {
        Users user = userService.getUserByID(user_id);
        user.setBaned(true);
        userService.updateUser(user);
        return "redirect:/user/" + user_id + "/profile";
    }

    @RequestMapping(value = "/{user_id}/removeBan", method = RequestMethod.POST)
    public String removeBan(@PathVariable("user_id") int user_id) {
        Users user = userService.getUserByID(user_id);
        user.setBaned(false);
        userService.updateUser(user);
        return "redirect:/user/" + user_id + "/profile";
    }

    @RequestMapping(value = "/editTel", method = RequestMethod.POST)
    public String editTel(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        Users user = userService.getUserByID(user_id);
        user.setTel(request.getParameter("newTel"));
        userService.updateUser(user);
        return "redirect:/user/userInfo";
    }

    @RequestMapping(value = "/editEmail", method = RequestMethod.POST)
    public String editEmail(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        Users user = userService.getUserByID(user_id);
        user.setEmail(request.getParameter("newEmail"));
        userService.updateUser(user);
        return "redirect:/user/userInfo";
    }

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    public String query(HttpServletRequest request) {
        String query = request.getParameter("query");
        List<Users> users;
        if (query.isEmpty())
            users = userService.getUserList();
        else
            users = userService.getUserByQuery(query);
        request.setAttribute("users", users);
        List<Transactions> transactionsList = userService.getTransList();
        request.setAttribute("trans", transactionsList);
        return "/user/admin";
    }

    @RequestMapping(value = "/editAvatar", method = RequestMethod.POST)
    public String editAvatar(HttpServletRequest request) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        AvatarHelper ah = new AvatarHelper();
        if (!ah.saveAvatarBase64ByUserId(user_id,
                request.getParameter("avatar-base64")))
            System.out.printf("Failed to save avatar for user %d\n", user_id);
        else
            System.out.printf("Successfully save avatar for user %d\n", user_id);
        return "redirect:/user/userInfo";
    }

    @RequestMapping(value = "/message", method = RequestMethod.GET)
    public String message(HttpServletRequest request, ModelMap modelMap) {
        int user_id = (int) request.getSession().getAttribute("user_id");
        List<Transactions> trans = userService.getTransBySellerID(user_id);

        if (trans == null) {
            modelMap.addAttribute("emptyMsg", "无消息");
            return "/user/message";
        }

        request.setAttribute("trans", trans);
        return "/user/message";
    }
}
