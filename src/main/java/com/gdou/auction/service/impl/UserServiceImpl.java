package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.PermissionMapper;
import com.gdou.auction.mapper.RoleMapper;
import com.gdou.auction.mapper.UserMapper;
import com.gdou.auction.pojo.*;
import com.gdou.auction.service.UserService;
import com.gdou.auction.util.PasswordHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * @author hua
 * @date 2020/3/22 - 10:49
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private PermissionMapper permissionMapper;
    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private PasswordHelper passwordHelper;

    @Override
    public User getUserByUsername(String username) {
        return userMapper.selectByUsername(username);
    }

    @Override
    public List<User> getAll() {
        return userMapper.selectByExampleWithRole(null);
    }

    @Override
    public int save(User user,Integer... roleIds) {
        passwordHelper.encryptPassword(user);
        userMapper.insertSelective(user);
        if (roleIds.length>0 && roleIds!=null){
            for (Integer i:roleIds){
                UserRole userRole = new UserRole();
                userRole.setRoleId(i);
                userRole.setUserId(user.getUserId());
                userMapper.addUserRole(userRole);
            }
        }
        return 1;
    }

    @Override
    public User getUserById(Integer userId) {
        return userMapper.selectByPrimaryKeyWithRole(userId);
    }

    @Override
    public int update(User user,Integer... roleIds) {
        //删除用户角色关联通过userId
        userMapper.delUserRole(user.getUserId());
        //再新增
        if (roleIds.length>0 && roleIds!=null){
            for (Integer i:roleIds){
                UserRole userRole = new UserRole();
                userRole.setRoleId(i);
                userRole.setUserId(user.getUserId());
                userMapper.addUserRole(userRole);
            }
        }
        return userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public int deleteOne(Integer userId) {
        userMapper.delUserRole(userId);
        return userMapper.deleteByPrimaryKey(userId);
    }

    @Override
    public void deleteAll(List<Integer> list) {
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andUserIdIn(list);
        userMapper.deleteByExample(userExample);
        for (Integer integer : list) {
            userMapper.delUserRole(integer);
        }
    }

    /**
     * 验证用户名
     * @param username
     */
    @Override
    public User checkUsername(String username) {
        return userMapper.selectByUsername(username);
    }

    /**
     * 获取菜单
     * @param username
     * @return
     */
    @Override
    public List<Navigation> getNavigationBar(String username) {
        List<Navigation> navigationBar = new ArrayList<Navigation>();
        Navigation navigation;
        //1.先通过username找到roles
        List<Role> roles = roleMapper.getRolesByUsername(username);
        for (Role role : roles) {
            //2.通过roles找到父id为0的navigation
            List<Permission> permissions = permissionMapper.getNavigationByRoleIdAndParentId(role.getRoleId(), 0);
            for (Permission permission : permissions) {
                navigation = new Navigation();
                navigation.setNavigationId(permission.getPermissionId());
                navigation.setNavigationName(permission.getName());
                navigation.setUrl(permission.getUrl());
                //查找子菜单,这只是一个两级菜单
                List<Permission> permissions1 = permissionMapper.getNavigationByRoleIdAndParentId(role.getRoleId(), permission.getPermissionId());
                navigation.setChildNavigations(permissions1);
                navigationBar.add(navigation);
            }
        }
        return navigationBar;
    }

    @Override
    public Set<String> getRolesByUsername(String username) {
        return userMapper.getRolesByUsername(username);
    }

    @Override
    public Set<String> getPermissionsByUsername(String username) {
        return userMapper.getPermissionsByUsername(username);
    }
}
