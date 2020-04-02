package com.gdou.auction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author hua
 * @date 2020/3/23 - 15:39
 */
@Controller
public class CommonController {

    @RequestMapping("/index")
    public String index(){
        return "index";
    }
    @RequestMapping("/main")
    public String main(){
        return "main";
    }
}
