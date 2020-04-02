package com.gdou.auction.controller;

import com.gdou.auction.pojo.Msg;
import com.gdou.auction.pojo.Permission;
import com.gdou.auction.pojo.Role;
import com.gdou.auction.service.PermissionService;
import com.gdou.auction.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author hua
 * @date 2020/3/25 - 10:43
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;
    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNum, Model model){
        PageHelper.startPage(pageNum,5);
        List<Role> list = roleService.getAll();
        PageInfo pageInfo = new PageInfo(list);
        model.addAttribute("pageInfo",pageInfo);
        return "role_list";
    }

    /**
     * 获取菜单树
     * @return
     */
    @ResponseBody
    @RequestMapping("/permTree")
    public Msg getPermissionTree(){
        List<Permission> permissions = roleService.getPermissionTree();
        return Msg.success().add("permTree",permissions);
    }

    @ResponseBody
    @PostMapping("/save")
    public Msg save(Role role,String permIds){
        int i = roleService.save(role,permIds);
        if (i>0){
            return Msg.success();
        }
        return Msg.faile();
    }

    /**
     * 获取权限
     * @param roleId
     * @return
     */
    @ResponseBody
    @RequestMapping("/getPermissions")
    public Msg getPermissionByRoleId(Integer roleId){
        List<Permission> permissions = permissionService.getPermissionByRoleId(roleId);
        return Msg.success().add("permissions",permissions);
    }

    @ResponseBody
    @RequestMapping("/show/{roleId}")
    public Msg getRoleByRoleId(@PathVariable Integer roleId){
        Role role = roleService.getRole(roleId);
        if (role == null) {
            return Msg.faile();
        }
        return Msg.success().add("role",role);
    }
    @ResponseBody
    @PutMapping("/update/{roleId}")
    public Msg update(Role role,String permIds){
        int i = roleService.update(role,permIds);
        if (i>0){
            return Msg.success();
        }
        return Msg.faile();
    }

    /**
     * 删除单个角色
     * @param roleId
     * @return
     */
    @ResponseBody
    @DeleteMapping("/delete/{roleId}")
    public Msg delete(@PathVariable Integer roleId){
        int i = roleService.delete(roleId);
        if (i>0){
            return Msg.success();
        }
        return Msg.faile();
    }

    @ResponseBody
    @DeleteMapping("/deleteBatch")
    public Msg deleteBatch(String roleIds){
        int i = roleService.deleteBatch(roleIds);
        if (i>0){
            return Msg.success();
        }
        return Msg.faile();
    }
}
