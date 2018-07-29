package com.yuki.decmarket.service;

import com.yuki.decmarket.mapper.GoodsMapper;
import com.yuki.decmarket.model.Goods;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodService {
	@Autowired
	private GoodsMapper goodsMapper;

	public Goods getGoodByID(int good_id) {
		return goodsMapper.getGoodByID(good_id);
	}

	public List<Goods> getAllGoods() {
		return goodsMapper.getAllGoods();
	}
}
