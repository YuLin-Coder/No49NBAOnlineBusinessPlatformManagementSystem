package org.healthbeauty.service;

import java.util.List;

import org.healthbeauty.pojo.Activity;
import org.healthbeauty.pojo.ActivityExample;
import org.healthbeauty.pojo.Goods;

public interface ActivityService {
    List<Activity> getAllActivity(ActivityExample activityExample);

    void insertActivitySelective(Activity activity);

    Activity selectByKey(Integer activityid);

    void deleteByActivityId(Integer activityid);

//    void updateGoodsActSelective(Goods goods);
}
