package org.healthbeauty.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.healthbeauty.pojo.Deliver;
import org.healthbeauty.pojo.DeliverExample;

public interface DeliverMapper {
    long countByExample(DeliverExample example);

    int deleteByExample(DeliverExample example);

    int deleteByPrimaryKey(Integer deliverid);

    int insert(Deliver record);

    int insertSelective(Deliver record);

    List<Deliver> selectByExample(DeliverExample example);

    Deliver selectByPrimaryKey(Integer deliverid);

    int updateByExampleSelective(@Param("record") Deliver record, @Param("example") DeliverExample example);

    int updateByExample(@Param("record") Deliver record, @Param("example") DeliverExample example);

    int updateByPrimaryKeySelective(Deliver record);

    int updateByPrimaryKey(Deliver record);
}