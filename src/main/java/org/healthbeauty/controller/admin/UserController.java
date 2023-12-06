package org.healthbeauty.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.healthbeauty.pojo.*;
import org.healthbeauty.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;


@Controller
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/showjson")
    @ResponseBody
    public Msg getAllGoods(@RequestParam(value = "page",defaultValue = "1") Integer pn, HttpServletResponse response, Model model) {
        //一页显示几个数据
        PageHelper.startPage(pn, 10);

        List<User> userList = userService.selectByExample(new UserExample());

        //显示几个页号
        PageInfo page = new PageInfo(userList,5);

       /* model.addAttribute("pageInfo", page);*/

        return Msg.success("查询成功!").add("pageInfo", page);
    }

    @RequestMapping("/show")
    public String userManage() {
        return "userManage";
    }

    @RequestMapping(value = "/delete/{userid}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteUser(@PathVariable("userid")Integer userid) {
//        goodsService.deleteGoodsById(goodsid);
        userService.deleteUserById(userid);
        return Msg.success("删除成功!");
    }

    @RequestMapping(value = "/savepsw/{userid}", method = RequestMethod.POST)
    @ResponseBody
    public Msg savePsw(@PathVariable("userid")Integer userid,String Psw)
    {
        User user=userService.selectByPrimaryKey(userid);
        user.setPassword(Psw);
        userService.updateByPrimaryKeySelective(user);
        return Msg.success("修改密码成功");
    }
}
