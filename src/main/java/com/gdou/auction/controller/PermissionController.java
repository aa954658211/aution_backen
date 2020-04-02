package com.gdou.auction.controller;

import com.gdou.auction.pojo.Msg;
import com.gdou.auction.pojo.Permission;
import com.gdou.auction.service.PermissionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author hua
 * @date 2020/3/31 - 19:56
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    /**
     * 列出权限列表
     * @param pageNum
     * @param model
     * @return
     */
    @RequestMapping("/list")
    public String getAll(@RequestParam(defaultValue = "1") Integer pageNum, Model model){
        PageHelper.startPage(pageNum,10);
        List<Permission> permissions = permissionService.getAll();
        PageInfo pageInfo = new PageInfo(permissions);
        model.addAttribute("pageInfo",pageInfo);
        return "permission_list";
    }

    @PostMapping("/save")
    @ResponseBody
    public Msg save(Permission permission){
        if (permission.getIsNav()==null){
            permission.setIsNav(0);
        }
        //处理没有勾选的时候
        if (permission.getStatus()==null){
            permission.setStatus(0);
        }
        permission.setCreateTime(new Date());
        int save = permissionService.save(permission);
        if (save != 0){
            return Msg.success();
        }
        return Msg.faile();
    }
    @ResponseBody
    @GetMapping("/getPermission/{permissionId}")
    public Msg getPermission(@PathVariable Integer permissionId){
        Permission permission = permissionService.getPermissionById(permissionId);
        return Msg.success().add("permission",permission);
    }

    @ResponseBody
    @PutMapping("/update/{permissionId}")
    public Msg update(Permission permission){
        int update = permissionService.update(permission);
        if (update!=0){
            return Msg.success();
        }
        return Msg.faile();
    }

    @ResponseBody
    @DeleteMapping("/delete/{permissionId}")
    public Msg delete(@PathVariable Integer permissionId){
        int delete = permissionService.delete(permissionId);
        if (delete!=0){
            return Msg.success();
        }
        return Msg.faile();
    }

    @ResponseBody
    @DeleteMapping("/deleteBatch")
    public Msg deleteBatch(String permissionIds){
        List<Integer> ids = new ArrayList<>();
        String[] split = permissionIds.split(" ");
        for (String s : split) {
            ids.add(Integer.parseInt(s));
        }
        int batch = permissionService.deleteBatch(ids);
        if (batch!=0){
            return Msg.success();
        }
        return Msg.faile();
    }
}
