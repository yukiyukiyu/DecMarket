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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
		System.out.println(goods);
		request.setAttribute("goods", goods);
		return "/good/goodList";
	}

	@RequestMapping(value = "/{good_id}", method = RequestMethod.GET)
	public String showGood(@PathVariable("good_id") int good_id, HttpServletRequest request,
	                       ModelMap modelMap) {
		Goods good = goodService.getGoodByID(good_id);
		if(good.getDeletedAt() != null) {
			modelMap.addAttribute("deletedGood", "此商品已被删除！");
		} else {
			request.setAttribute("good", good);

			List<GoodsTags> record = goodTagService.getRecordByGoodID(good_id);
			List<Tags> tags = new ArrayList<>();
			for(GoodsTags it : record) {
				Tags tag = goodTagService.getTagByID(it.getTagId());
				tags.add(tag);
			}
			request.setAttribute("tags", tags);
		}

		Users seller = userService.getUserByID(good.getUserId());
		request.setAttribute("seller", seller);

		UserInfo sellerInfo = userService.getUserInfoByID(seller.getId());
		request.setAttribute("sellerInfo", sellerInfo);

		if(request.getSession().getAttribute("user_id") != null) {
			int user_id = (int) request.getSession().getAttribute("user_id");
			List<Favlists> favlists = userService.getFavListByID(user_id);
			for(Favlists it : favlists) {
				if(it.getGoodId() == good_id) {
					modelMap.addAttribute("isInFavList", "已收藏");
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
		newgood.setUserId(user_id);
		goodService.addGood(newgood);
		return "redirect:/good/" + user_id + "/sell";
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
			record.setGoodId(good_id);
			record.setTagId(it);
			goodTagService.addRecord(record);
		}
		return "redirect:/good/" + good_id;
	}
}
