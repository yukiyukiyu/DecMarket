package com.yuki.decmarket.service;

import com.yuki.decmarket.mapper.GoodsTagsMapper;
import com.yuki.decmarket.mapper.TagsMapper;
import com.yuki.decmarket.model.GoodsTags;
import com.yuki.decmarket.model.Tags;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodTagService {
	@Autowired
	private GoodsTagsMapper goodsTagsMapper;

	private TagsMapper tagsMapper;

	public List<GoodsTags> getRecordByGoodID(int good_id) {
		return goodsTagsMapper.getRecordByGoodID(good_id);
	}

	public void deleteRecordByID(int id) {
		goodsTagsMapper.deleteByPrimaryKey(id);
	}

	public Tags getTagByName(String name) {
		return tagsMapper.getTagByName(name);
	}

	public Tags getTagByID(int tag_id) {
		return tagsMapper.selectByPrimaryKey(tag_id);
	}

	public Tags insertTag(Tags tag) {
		tagsMapper.insert(tag);
		return getTagByName(tag.getName());
	}

	public void addRecord(GoodsTags record) {
		goodsTagsMapper.insert(record);
	}
}
