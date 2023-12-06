package org.healthbeauty.service;

import java.util.List;

import org.healthbeauty.pojo.User;
import org.healthbeauty.pojo.UserExample;

public interface UserService {
    public User selectByPrimaryKey(int userId);
    /*public User selectByPrimaryKeyAndPassword(int userId,String password);*/
    public List<User> selectByExample(UserExample userExample);

    public void insertSelective(User user);

    public void deleteUserById(Integer userid);

    public void updateByPrimaryKeySelective(User user);

}
