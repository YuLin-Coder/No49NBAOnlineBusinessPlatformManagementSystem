package org.healthbeauty.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.healthbeauty.pojo.*;


public interface GoodsService {
    public Integer addGoods(Goods goods);

    public void addImagePath(ImagePath imagePath);

    public List<Goods> selectByExample(GoodsExample example);


    public List<Goods> selectList( List<Integer> list);



    public void deleteGoodsById(Integer goodsid);

    public void updateGoodsById(Goods goods);

    public List<ImagePath> findImagePath(Integer goodsid);

    public Goods selectById(Integer goodsid);

    public List<Goods> selectByExampleLimit(GoodsExample digGoodsExample);

    public void addFavorite(Favorite favorite);

    public Favorite selectFavByKey(FavoriteKey favoriteKey);

    public void deleteFavByKey(FavoriteKey favoriteKey);

    public List<Favorite> selectFavByExample(FavoriteExample favoriteExample);
}
