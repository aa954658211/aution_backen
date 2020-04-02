package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.PermissionMapper;
import com.gdou.auction.mapper.RoleMapper;
import com.gdou.auction.pojo.Permission;
import com.gdou.auction.pojo.Role;
import com.gdou.auction.pojo.RoleExample;
import com.gdou.auction.pojo.RolePermission;
import com.gdou.auction.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author hua
 * @date 2020/3/25 - 10:42
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public List<Role> getAll() {
        return roleMapper.selectByExample(null);
    }

    @Override
    public List<Permission> getPermissionTree() {
        return permissionMapper.selectByExample(null);
    }

    @Override
    public int save(Role role, String permIds) {
        role.setCreateTime(new Date());
        roleMapper.insertSelective(role);
        addRolePermission(role,permIds);
        return 1;
    }

    public void addRolePermission(Role role, String permIds){
        String[] split = permIds.split(",");
        for (String permId : split){
            RolePermission rolePermission = new RolePermission();
            rolePermission.setPermissionId(Integer.parseInt(permId));
            rolePermission.setRoleId(role.getRoleId());
            roleMapper.addRolePermission(rolePermission);
        }
    }

    @Override
    public Role getRole(Integer roleId) {
        return roleMapper.selectByPrimaryKey(roleId);
    }

    @Override
    public int update(Role role, String permIds) {
        roleMapper.updateByPrimaryKeySelective(role);
        roleMapper.delRolePermission(role.getRoleId());
        addRolePermission(role,permIds);
        return 1;
    }

    @Override
    public int delete(Integer roleId) {
        roleMapper.delRolePermission(roleId);
        return roleMapper.deleteByPrimaryKey(roleId);
    }
    /**
     * 批量删除
     * @param roleIds
     * @return
     */
    @Override
    public int deleteBatch(String roleIds) {
        List<Integer> list = new ArrayList<>();
        String[] ids = roleIds.split(" ");
        for (String id : ids) {
            Integer roleId = Integer.parseInt(id);
            //角色权限关系
            roleMapper.delRolePermission(roleId);
            list.add(roleId);
        }
        RoleExample roleExample = new RoleExample();
        roleExample.createCriteria().andRoleIdIn(list);
        return roleMapper.deleteByExample(roleExample);
    }
}
