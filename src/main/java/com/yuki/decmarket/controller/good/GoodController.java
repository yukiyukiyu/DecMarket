package com.yuki.decmarket.controller.good;

import com.yuki.decmarket.model.*;
import com.yuki.decmarket.service.GoodService;
import com.yuki.decmarket.service.GoodTagService;
import com.yuki.decmarket.service.UserService;
import org.dozer.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.support.SimpleTriggerContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import com.yuki.decmarket.controller.good.GoodForm.NewGood;

import javax.servlet.http.HttpServletRequest;
import javax.swing.text.html.HTML;
import javax.validation.groups.Default;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/good")
public class GoodController {
	@Autowired
	protected Mapper beanMapper;

	@Autowired
	protected GoodService goodService;

	@Autowired
	protected UserService userService;

	@Autowired
	protected GoodTagService goodTagService;

	@ModelAttribute
	public GoodForm setUpGoodForm() {
		return new GoodForm();
	}

	@RequestMapping(method = RequestMethod.GET)
	public String getAllGoods(HttpServletRequest request) {
		List<Goods> goods = goodService.getAllGoods();
		request.setAttribute("goods", goods);
		return "/good/goodList";
	}

	@RequestMapping(value = "/{good_id}", method = RequestMethod.GET)
	public String showGood(@PathVariable("good_id") int good_id, HttpServletRequest request,
	                       ModelMap modelMap) {
		Goods good = goodService.getGoodByID(good_id);
		if(good.getDeleted_at() != null) {
			modelMap.addAttribute("deletedGood", "此商品已被删除！");
			return "good/goodInfo";
		} else {
			request.setAttribute("good", good);

			List<GoodsTags> record = goodTagService.getRecordByGoodID(good_id);
			List<Tags> tags = new ArrayList<>();
			for(GoodsTags it : record) {
				Tags tag = goodTagService.getTagByID(it.getTag_id());
				tags.add(tag);
			}
			request.setAttribute("tags", tags);
		}

		Users seller = userService.getUserByID(good.getUser_id());
		request.setAttribute("seller", seller);

		UserInfo sellerInfo = userService.getUserInfoByID(seller.getId());
		request.setAttribute("sellerInfo", sellerInfo);

		if(request.getSession().getAttribute("user_id") != null) {
			int user_id = (int) request.getSession().getAttribute("user_id");
			List<Favlists> favlists = userService.getFavListByID(user_id);
			for(Favlists it : favlists) {
				System.out.println(it.getGood_id());
				if(it.getGood_id() != null && it.getGood_id() == good_id) {
					System.out.println("???");
					modelMap.addAttribute("isInFavList", 1);
					break;
				}
			}
		}
		return "/good/goodInfo";
	}

	@RequestMapping(value = "/addGoodForm", method = RequestMethod.GET)
	public String addGoodForm() {
		return "/good/addGoodForm";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addGood(@Validated({NewGood.class, Default.class}) GoodForm form,
	                      HttpServletRequest request, ModelMap modelMap) {
		int user_id = (int) request.getSession().getAttribute("user_id");
		Users user = userService.getUserByID(user_id);
		Goods newgood = beanMapper.map(form, Goods.class);
		newgood.setUser_id(user_id);
		goodService.addGood(newgood);
		return "redirect:/good/" + newgood.getId();
	}

	@RequestMapping(value = "/{good_id}/delete", method = RequestMethod.POST)
	public String deleteGood(@PathVariable("good_id") int good_id) {
		goodService.deleteGoodByID(good_id);
		List<GoodsTags> records = goodTagService.getRecordByGoodID(good_id);
		for(GoodsTags it : records) {
			goodTagService.deleteRecordByID(it.getId());
		}
		return "redirect:/good";
	}

	@RequestMapping(value = "/{good_id}/addTags", method = RequestMethod.POST)
	public String addTagsByGoodID(@PathVariable("good_id") int good_id,
	                              HttpServletRequest request) {
		String tags = request.getParameter("tags");
		List<String> tagList = new ArrayList<>(Arrays.asList(tags.split(" ")));
		List<Integer> tagIDList = new ArrayList<>();
		for(String it : tagList) {
			Tags tag = goodTagService.getTagByName(it);
			if(tag != null) {
				tagIDList.add(tag.getId());
				continue;
			}
			Tags newtag = new Tags();
			newtag.setName(it);
			tag = goodTagService.insertTag(newtag);
			tagIDList.add(tag.getId());
		}
		for(int it : tagIDList) {
			GoodsTags record = new GoodsTags();
			record.setGood_id(good_id);
			record.setTag_id(it);
			goodTagService.addRecord(record);
		}
		return "redirect:/good/" + good_id;
	}

	@RequestMapping(value = "/{good_id}/addFavList", method = RequestMethod.POST)
	public String addFavList(@PathVariable("good_id") int good_id,
	                         HttpServletRequest request) {
		int user_id = (int) request.getSession().getAttribute("user_id");
		Favlists favlist = new Favlists();
		favlist.setGood_id(good_id);
		favlist.setUser_id(user_id);
		goodService.addFavList(favlist);
		return "redirect:/good/" + good_id;
	}

	@RequestMapping(value = "/{good_id}/delFavList", method = RequestMethod.POST)
	public String delFavList(@PathVariable("good_id") int good_id,
	                         HttpServletRequest request) {
		int user_id = (int) request.getSession().getAttribute("user_id");
		List<Favlists> favlists = userService.getFavListByID(user_id);
		for(Favlists it : favlists) {
			if(it.getGood_id() == good_id) {
				goodService.delFavList(it.getId());
			}
		}
		return "redirect:/good/" + good_id;
	}

	@RequestMapping(value = "/{good_id}/buy", method = RequestMethod.POST)
	public String buy(@PathVariable("good_id") int good_id,
	                  HttpServletRequest request) {
		int buyer_id = (int) request.getSession().getAttribute("user_id");
		Transactions transaction = new Transactions();
		transaction.setGood_id(good_id);
		transaction.setBuyer_id(buyer_id);
		transaction.setNumber(Integer.parseInt(request.getParameter("count")));
		transaction.setStatus((short) 1);
		goodService.addTrans(transaction);

		Goods good = goodService.getGoodByID(good_id);
		good.setCount(good.getCount() - transaction.getNumber());
		goodService.updateGood(good);
		return "redirect:/user/trans";
	}
}
