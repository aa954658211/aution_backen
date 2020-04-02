package com.gdou.auction.mapper;

import com.gdou.auction.pojo.Role;
import com.gdou.auction.pojo.RoleExample;
import com.gdou.auction.pojo.RolePermission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleMapper {
    long countByExample(RoleExample example);

    int deleteByExample(RoleExample example);

    int deleteByPrimaryKey(Integer roleId);

    int insert(Role record);

    int insertSelective(Role record);

    List<Role> selectByExample(RoleExample example);

    Role selectByPrimaryKey(Integer roleId);

    int updateByExampleSelective(@Param("record") Role record, @Param("example") RoleExample example);

    int updateByExample(@Param("record") Role record, @Param("example") RoleExample example);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

    int addRolePermission(RolePermission rolePermission);

    int delRolePermission(Integer roleId);

    List<Role> getRolesByUsername(String username);

}