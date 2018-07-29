package com.yuki.decmarket.controller.good;

import com.yuki.decmarket.model.Goods;
import com.yuki.decmarket.service.GoodService;
import org.dozer.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/good")
public class GoodController {
	@Autowired
	protected Mapper beanMapper;

	@Autowired
	protected GoodService goodService;

	@RequestMapping(method = RequestMethod.GET)
	public String getAllGoods(HttpServletRequest request) {
		List<Goods> allGoods = goodService.getAllGoods();
		request.setAttribute("allGoods", allGoods);
		return "/good/goodList";
	}
}
