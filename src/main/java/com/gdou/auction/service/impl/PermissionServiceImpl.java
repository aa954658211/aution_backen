package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.PermissionMapper;
import com.gdou.auction.pojo.Permission;
import com.gdou.auction.pojo.PermissionExample;
import com.gdou.auction.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author hua
 * @date 2020/3/30 - 21:07
 */
@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public List<Permission> getPermissionByRoleId(Integer roleId) {
        return permissionMapper.getPermissionByRoleId(roleId);
    }

    @Override
    public List<Permission> getAll() {
        return permissionMapper.selectByExample(null);
    }

    @Override
    public int save(Permission permission) {
        return permissionMapper.insertSelective(permission);
    }

    @Override
    public Permission getPermissionById(Integer permissionId) {
        return permissionMapper.selectByPrimaryKey(permissionId);
    }

    @Override
    public int update(Permission permission) {
        return permissionMapper.updateByPrimaryKeySelective(permission);
    }

    @Override
    public int delete(Integer permissionId) {
        return permissionMapper.deleteByPrimaryKey(permissionId);
    }

    @Override
    public int deleteBatch(List<Integer> permissionIds) {
        PermissionExample permissionExample = new PermissionExample();
        permissionExample.createCriteria().andPermissionIdIn(permissionIds);
        return permissionMapper.deleteByExample(permissionExample);
    }
}
