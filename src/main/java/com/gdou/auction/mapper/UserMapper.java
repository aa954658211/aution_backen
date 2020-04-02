package com.gdou.auction.mapper;

import com.gdou.auction.pojo.User;
import com.gdou.auction.pojo.UserExample;
import com.gdou.auction.pojo.UserRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

public interface UserMapper {
    long countByExample(UserExample example);

    int deleteByExample(UserExample example);

    int deleteByPrimaryKey(Integer userId);

    int insert(User record);

    int insertSelective(User record);

    List<User> selectByExample(UserExample example);

    User selectByPrimaryKey(Integer userId);

    int updateByExampleSelective(@Param("record") User record, @Param("example") UserExample example);

    int updateByExample(@Param("record") User record, @Param("example") UserExample example);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    /**
     * 查询全部带角色的user
     * @param example
     * @return
     */
    List<User> selectByExampleWithRole(UserExample example);

    User selectByPrimaryKeyWithRole(Integer userId);
    User selectByUsername(String username);

    /**
     *添加用户角色关联
     * @param userRole
     * @return
     */
    int addUserRole(UserRole userRole);

    int delUserRole(Integer userId);
    Set<String> getRolesByUsername(String username);
    Set<String> getPermissionsByUsername(String username);

}