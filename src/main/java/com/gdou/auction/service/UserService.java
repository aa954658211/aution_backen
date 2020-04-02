package com.gdou.auction.service;

import com.gdou.auction.pojo.Navigation;
import com.gdou.auction.pojo.User;

import java.util.List;
import java.util.Set;

/**
 * @author hua
 * @date 2020/3/22 - 10:47
 */
public interface UserService {
    User getUserByUsername(String username);
    List<User> getAll();
    User getUserById(Integer userId);
    int update(User user,Integer... roleIds);
    int save(User user,Integer... roleIds);
    int deleteOne(Integer userId);

    void deleteAll(List<Integer> list);

    User checkUsername(String username);

    /**
     * 用于登录认证时候
     * @param username
     * @return
     */
    List<Navigation> getNavigationBar(String username);

    /**
     * 两个授权方法
     * @param username
     * @return
     */
    Set<String> getRolesByUsername(String username);
    Set<String> getPermissionsByUsername(String username);
}
