package org.healthbeauty.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.healthbeauty.pojo.Category;
import org.healthbeauty.pojo.CategoryExample;

public interface CategoryMapper {
    long countByExample(CategoryExample example);

    int deleteByExample(CategoryExample example);

    int deleteByPrimaryKey(Integer cateid);

    int insert(Category record);

    int insertSelective(Category record);

    List<Category> selectByExample(CategoryExample example);

    List<Category> selectByExampleLimit(CategoryExample example);

    Category selectByPrimaryKey(Integer cateid);

    int updateByExampleSelective(@Param("record") Category record, @Param("example") CategoryExample example);

    int updateByExample(@Param("record") Category record, @Param("example") CategoryExample example);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);
}