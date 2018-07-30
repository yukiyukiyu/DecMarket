package com.yuki.decmarket.controller.good;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class GoodForm {
	public static interface NewGood {
	}

	@NotNull
	@Size(min = 1, max = 50)
	private String name;

	@NotNull
	private double price;

	@NotNull
	private int count;

	@NotNull
	private String description;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
