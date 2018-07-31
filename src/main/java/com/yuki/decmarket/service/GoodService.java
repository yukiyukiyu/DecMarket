package com.yuki.decmarket.service;

import com.yuki.decmarket.mapper.FavlistsMapper;
import com.yuki.decmarket.mapper.GoodsMapper;
import com.yuki.decmarket.mapper.TransactionsMapper;
import com.yuki.decmarket.model.Favlists;
import com.yuki.decmarket.model.Goods;
import com.yuki.decmarket.model.Transactions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodService {
	@Autowired
	private GoodsMapper goodsMapper;

	@Autowired
	private FavlistsMapper favlistsMapper;

	@Autowired
	private TransactionsMapper transactionsMapper;

	public Goods getGoodByID(int good_id) {
		return goodsMapper.getGoodByID(good_id);
	}

	public List<Goods> getGoodByUserID(int user_id) {
		return goodsMapper.getGoodByUserID(user_id);
	}

	public List<Goods> getAllGoods() {
		return goodsMapper.getAllGoods();
	}

	public void addGood(Goods good) {
		goodsMapper.insert(good);
	}

	public void deleteGoodByID(int good_id) {
		goodsMapper.deleteGoodByID(good_id);
	}

	public void addFavList(Favlists favlist) {
		favlistsMapper.insert(favlist);
	}

	public void delFavList(int id) {
		favlistsMapper.deleteByPrimaryKey(id);
	}

	public void addTrans(Transactions transaction) {
		transactionsMapper.insert(transaction);
	}

	public void updateGood(Goods good) {
		goodsMapper.updateByPrimaryKey(good);
	}
}
