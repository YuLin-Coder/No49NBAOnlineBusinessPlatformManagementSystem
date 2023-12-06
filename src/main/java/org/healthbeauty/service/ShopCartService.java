package org.healthbeauty.service;

import java.util.List;

import org.healthbeauty.pojo.ShopCart;
import org.healthbeauty.pojo.ShopCartExample;
import org.healthbeauty.pojo.ShopCartKey;

public interface ShopCartService {
    public void addShopCart(ShopCart shopCart);

    public List<ShopCart> selectByExample(ShopCartExample shopCartExample);

    public void deleteByKey(ShopCartKey shopCartKey);

    public void updateCartByKey(ShopCart shopCart);

    public ShopCart selectCartByKey(ShopCartKey shopCartKey);
}
