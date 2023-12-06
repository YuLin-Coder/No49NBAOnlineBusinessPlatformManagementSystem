package org.healthbeauty.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.healthbeauty.pojo.Favorite;
import org.healthbeauty.pojo.FavoriteExample;
import org.healthbeauty.pojo.FavoriteKey;

public interface FavoriteMapper {
    long countByExample(FavoriteExample example);

    int deleteByExample(FavoriteExample example);

    int deleteByPrimaryKey(FavoriteKey key);

    int insert(Favorite record);

    int insertSelective(Favorite record);

    List<Favorite> selectByExample(FavoriteExample example);

    Favorite selectByPrimaryKey(FavoriteKey key);

    int updateByExampleSelective(@Param("record") Favorite record, @Param("example") FavoriteExample example);

    int updateByExample(@Param("record") Favorite record, @Param("example") FavoriteExample example);

    int updateByPrimaryKeySelective(Favorite record);

    int updateByPrimaryKey(Favorite record);
}