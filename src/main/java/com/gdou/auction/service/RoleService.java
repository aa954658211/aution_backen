package com.gdou.auction.service;

import com.gdou.auction.pojo.Permission;
import com.gdou.auction.pojo.Role;

import java.util.List;

/**
 * @author hua
 * @date 2020/3/25 - 10:41
 */
public interface RoleService {
    List<Role> getAll();

    List<Permission> getPermissionTree();

    int save(Role role, String permIds);

    Role getRole(Integer roleId);

    int update(Role role, String permIds);

    int delete(Integer roleId);

    int deleteBatch(String roleIds);

}
