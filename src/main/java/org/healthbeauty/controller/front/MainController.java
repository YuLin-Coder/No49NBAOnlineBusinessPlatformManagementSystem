package org.healthbeauty.controller.front;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.healthbeauty.pojo.*;
import org.healthbeauty.service.CateService;
import org.healthbeauty.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {

	@Autowired
	private CateService cateService;

	@Autowired
	private GoodsService goodsService;

	@RequestMapping("/main")
	public String showAllGoods(Model model, HttpSession session) {

		Integer userid;
		User user = (User) session.getAttribute("user");
		if (user == null) {
			userid = null;
		} else {
			userid = user.getUserid();
		}
		
		/*Goods meirong = getNews(1);
		Goods remen = getNews(2);
		Goods mingxing = getNews(3);
		if(null!=meirong){
			model.addAttribute("meirong", meirong);
		}
		if(null!=remen){
			model.addAttribute("remen", remen);
		}
		if(null!=mingxing){
			model.addAttribute("mingxing", mingxing);
		}*/
		
		List<Goods> newsList = listNews(1);
		if(null!=newsList){
			model.addAttribute("newsList", newsList);
		}
		
		
		
//		// 新疆知识
//		GoodsExample goodExample = new GoodsExample();
//		com.neu.shop.pojo.GoodsExample.Criteria criteria = goodExample.createCriteria();
//		criteria.andCategoryEqualTo(1);
//		goodExample.setOrderByClause("upTime desc");
//
//		List<Goods> goodsList = goodsService.selectByExample(goodExample);
//		if (!goodsList.isEmpty()) {
//			List<ImagePath> imagePathList = goodsService.findImagePath(goodsList.get(0).getGoodsid());
//			goodsList.get(0).setImagePaths(imagePathList);
//			if (goodsList.get(0).getDescription().length() > 25) {
//				goodsList.get(0).setDescription(goodsList.get(0).getDescription().substring(0, 20));
//			}
//
//			model.addAttribute("meirong", goodsList.get(0));
//		}
//
//		// 新疆风景
//		GoodsExample goodExample2 = new GoodsExample();
//		com.neu.shop.pojo.GoodsExample.Criteria criteria2 = goodExample2.createCriteria();
//		criteria2.andCategoryEqualTo(2);
//		goodExample2.setOrderByClause("upTime desc");
//
//		List<Goods> goodsList2 = goodsService.selectByExample(goodExample2);
//		if (!goodsList2.isEmpty()) {
//			List<ImagePath> imagePathList = goodsService.findImagePath(goodsList2.get(0).getGoodsid());
//			goodsList2.get(0).setImagePaths(imagePathList);
//			if (goodsList2.get(0).getDescription().length() > 25) {
//				goodsList2.get(0).setDescription(goodsList2.get(0).getDescription().substring(0, 20));
//			}
//			model.addAttribute("remen", goodsList2.get(0));
//		}
//
//		// 新疆特产
//		GoodsExample goodExample3 = new GoodsExample();
//		com.neu.shop.pojo.GoodsExample.Criteria criteria3 = goodExample3.createCriteria();
//		criteria3.andCategoryEqualTo(3);
//		goodExample3.setOrderByClause("upTime desc");
//
//		List<Goods> goodsList3 = goodsService.selectByExample(goodExample3);
//		if (!goodsList3.isEmpty()) {
//			List<ImagePath> imagePathList = goodsService.findImagePath(goodsList3.get(0).getGoodsid());
//			goodsList3.get(0).setImagePaths(imagePathList);
//			if (goodsList3.get(0).getDescription().length() > 25) {
//				goodsList3.get(0).setDescription(goodsList3.get(0).getDescription().substring(0, 20));
//			}
//			model.addAttribute("mingxing", goodsList3.get(0));
//		}

		// //数码分类
		// List<Goods> digGoods = getCateGoods("数码", userid);
		// model.addAttribute("digGoods", digGoods);
		//
		// //家电
		// List<Goods> houseGoods = getCateGoods("家电", userid);
		// model.addAttribute("houseGoods", houseGoods);
		//
		// //服饰
		// List<Goods> colGoods = getCateGoods("服饰", userid);
		// model.addAttribute("colGoods", colGoods);
		//
		// //书籍
		// List<Goods> bookGoods = getCateGoods("书籍", userid);
		// model.addAttribute("bookGoods", bookGoods);

		return "main";
	}

	@RequestMapping("/listgoods")
	@ResponseBody
	public Msg getAllGoods(@RequestParam(value = "pn", defaultValue = "1") Integer pn, HttpSession session) {
		Integer userid;
		User user = (User) session.getAttribute("user");
		if (user == null) {
			userid = null;
		} else {
			userid = user.getUserid();
		}
		PageHelper.startPage(pn, 5);
		GoodsExample goodExample = new GoodsExample();
		org.healthbeauty.pojo.GoodsExample.Criteria criteria = goodExample.createCriteria();
		criteria.andCategoryNotIn(Arrays.asList(new Integer[] { 1, 2, 3 }));
		List<Goods> goodsList = goodsService.selectByExample(goodExample);
		// 获取每个商品的图片
		for (Goods goods : goodsList) {
			if(goods.getGoodsname().length()>11){
				goods.setGoodsname(goods.getGoodsname().substring(0, 10)+"...");
			}
			// 判断是否为登录状态
			if (userid == null) {
				goods.setFav(false);
			} else {
				Favorite favorite = goodsService.selectFavByKey(new FavoriteKey(userid, goods.getGoodsid()));
				if (favorite == null) {
					goods.setFav(false);
				} else {
					goods.setFav(true);
				}
			}

			List<ImagePath> imagePathList = goodsService.findImagePath(goods.getGoodsid());
			goods.setImagePaths(imagePathList);
		}

		// 显示几个页号
		PageInfo<Goods> page = new PageInfo<Goods>(goodsList, 5);
		return Msg.success("查询成功!").add("pageInfo", page);
	}

	public List<Goods> getCateGoods(String cate, Integer userid) {
		// 查询分类
		CategoryExample digCategoryExample = new CategoryExample();
		digCategoryExample.or().andCatenameLike(cate);
		List<Category> digCategoryList = cateService.selectByExample(digCategoryExample);

		if (digCategoryList.size() == 0) {
			return null;
		}

		// 查询属于刚查到的分类的商品
		GoodsExample digGoodsExample = new GoodsExample();
		List<Integer> digCateId = new ArrayList<Integer>();
		for (Category tmp : digCategoryList) {
			digCateId.add(tmp.getCateid());
		}
		digGoodsExample.or().andCategoryIn(digCateId);

		List<Goods> goodsList = goodsService.selectByExampleLimit(digGoodsExample);

		List<Goods> goodsAndImage = new ArrayList<>();
		// 获取每个商品的图片
		for (Goods goods : goodsList) {
			// 判断是否为登录状态
			
			
			if (userid == null) {
				goods.setFav(false);
			} else {
				Favorite favorite = goodsService.selectFavByKey(new FavoriteKey(userid, goods.getGoodsid()));
				if (favorite == null) {
					goods.setFav(false);
				} else {
					goods.setFav(true);
				}
			}

			List<ImagePath> imagePathList = goodsService.findImagePath(goods.getGoodsid());
			goods.setImagePaths(imagePathList);
			goodsAndImage.add(goods);
		}
		return goodsAndImage;
	}
	
	public Goods getNews(int newsId){
		GoodsExample goodExample = new GoodsExample();
		org.healthbeauty.pojo.GoodsExample.Criteria criteria = goodExample.createCriteria();
		criteria.andCategoryEqualTo(newsId);
		goodExample.setOrderByClause("upTime desc");

		List<Goods> goodsList = goodsService.selectByExample(goodExample);
		if (!goodsList.isEmpty()) {
			
			List<ImagePath> imagePathList = goodsService.findImagePath(goodsList.get(0).getGoodsid());
			goodsList.get(0).setImagePaths(imagePathList);
			if (goodsList.get(0).getDescription().length() > 55) {
				goodsList.get(0).setDescription(goodsList.get(0).getDescription().substring(0, 50)+"...");
			}
			return goodsList.get(0);
			
		}
		return null;
	}
	
	//获取6条资讯
	public List<Goods> listNews(int newsId){
		GoodsExample goodExample = new GoodsExample();
		org.healthbeauty.pojo.GoodsExample.Criteria criteria = goodExample.createCriteria();
		criteria.andCategoryEqualTo(newsId);
		goodExample.setOrderByClause("upTime desc");

		List<Goods> goodsList = goodsService.selectByExample(goodExample);
		if (!goodsList.isEmpty()) {
			
			List<Goods> goodsAndImage = new ArrayList<>();
			for (Goods goods : goodsList) {
				List<ImagePath> imagePathList = goodsService.findImagePath(goods.getGoodsid());
				goods.setImagePaths(imagePathList);
				if (goods.getDescription().length() > 55) {
					goods.setDescription(goods.getDescription().substring(0, 50)+"...");
				}
				goodsAndImage.add(goods);
			}
			
			if(goodsAndImage.size()>6){
				return goodsAndImage.subList(0, 6);
			}
			return goodsAndImage;
			
		}
		return null;
	}
	
}
