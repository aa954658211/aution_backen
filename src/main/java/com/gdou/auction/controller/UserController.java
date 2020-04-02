package com.gdou.auction.controller;

import com.gdou.auction.pojo.Msg;
import com.gdou.auction.pojo.Role;
import com.gdou.auction.pojo.User;
import com.gdou.auction.service.RoleService;
import com.gdou.auction.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author hua
 * @date 2020/3/22 - 10:53
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    /**
     * 用户登录
     *
     * @return
     */
    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    /**
     * 分页查询用户列表
     *
     * @param pageNum
     * @param model
     * @return
     */
    @RequestMapping("/list")
    public String list(@RequestParam(defaultValue = "1", value = "pageNum") Integer pageNum, Model model) {
        PageHelper.startPage(pageNum, 5);
        List<User> users = userService.getAll();
        PageInfo pageInfo = new PageInfo(users);
        model.addAttribute("pageInfo", pageInfo);
        return "user_list";
    }

    @RequestMapping("/listRoles")
    @ResponseBody
    public Msg listRoles() {
        List<Role> roles = roleService.getAll();
        return Msg.success().add("roles", roles);
    }

    @ResponseBody
    @PostMapping("/save")
    public Msg save(User user, Integer... roleIds) {
        user.setStatus(1);
        int save = userService.save(user, roleIds);
        if (save != 0) {
            return Msg.success();
        }
        return Msg.faile();
    }

    @ResponseBody
    @GetMapping("/show/{userId}")
    public Msg getUser(@PathVariable("userId") Integer userId) {
        User user = userService.getUserById(userId);
        return Msg.success().add("user", user);
    }

    @ResponseBody
    @PutMapping("/update/{userId}")
    public Msg update(User user, Integer... roleIds) {
        int i = userService.update(user, roleIds);
        if (i > 0) {
            return Msg.success();
        }
        return Msg.faile();
    }

    /**
     * 删除单个用户
     *
     * @param userId
     * @return
     */
    @ResponseBody
    @DeleteMapping("/delete/{userId}")
    public Msg deleteOne(@PathVariable Integer userId) {
        int i = userService.deleteOne(userId);
        if (i > 0) {
            return Msg.success();
        }
        return Msg.faile();
    }

    @ResponseBody
    @DeleteMapping("/deleteAll")
    public Msg deleteAll(String userIds) {
        List<Integer> list = new ArrayList<>();
        String[] ids = userIds.split(" ");
        for (String id : ids) {
            list.add(Integer.parseInt(id));
        }
        userService.deleteAll(list);
        return Msg.success();
    }

    @RequestMapping("/checkUsername")
    @ResponseBody
    public Map checkUsername(String username) {
        User user = userService.checkUsername(username);
        Map<String, Object> map = new HashMap<>();
        if (user != null) {
            map.put("valid", false);
        } else {
            map.put("valid", true);
        }
        return map;
    }
}
