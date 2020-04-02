package com.gdou.auction.util;

import com.gdou.auction.mapper.PermissionMapper;
import com.gdou.auction.mapper.RoleMapper;
import com.gdou.auction.pojo.Permission;
import com.gdou.auction.pojo.RolePermission;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @author hua
 * @date 2020/3/30 - 13:52
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class RoleMapperTest {
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private PermissionMapper permissionMapper;

    @Test
    public void test(){
        RolePermission rolePermission = new RolePermission();
        rolePermission.setPermissionId(5);
        rolePermission.setRoleId(2);
        roleMapper.addRolePermission(rolePermission);
    }
    @Test
    public void test2(){
        List<Permission> permissions = permissionMapper.getPermissionByRoleId(12);
        for (Permission permission : permissions) {
            System.out.println(permission);
        }
    }
}
