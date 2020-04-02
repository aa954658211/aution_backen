package com.gdou.auction.service;

import com.gdou.auction.pojo.Permission;

import java.util.List;

/**
 * @author hua
 * @date 2020/3/30 - 21:07
 */
public interface PermissionService {
    List<Permission> getPermissionByRoleId(Integer roleId);

    List<Permission> getAll();

    int save(Permission permission);

    Permission getPermissionById(Integer permissionId);

    int update(Permission permission);

    int delete(Integer permissionId);

    int deleteBatch(List<Integer> permissionIds);
}
