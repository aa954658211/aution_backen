package com.gdou.auction.filter;

import com.gdou.auction.pojo.Navigation;
import com.gdou.auction.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author hua
 * @date 2020/4/1 - 16:27
 */
public class WithNavibarFormAuthenticationFilter extends FormAuthenticationFilter {
    @Autowired
    private UserService userService;
    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpReq=(HttpServletRequest)request;
        String username =(String) SecurityUtils.getSubject().getPrincipal();
        List<Navigation> navigationBar = userService.getNavigationBar(username);
        httpReq.getSession().setAttribute("navbar",navigationBar);
        httpReq.setAttribute("message","登录成功");
        return super.onLoginSuccess(token, subject, request, response);
    }

    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        String className = e.getClass().getName(), message = "";
        if (IncorrectCredentialsException.class.getName().equals(className)
                || UnknownAccountException.class.getName().equals(className)){
            message = "用户或密码错误, 请重试.";
        }
        else{
            message = "系统出现点问题，请稍后再试！";
            e.printStackTrace(); // 输出到控制台
        }
        request.setAttribute(getFailureKeyAttribute(), className);
        request.setAttribute("message", message);
        return super.onLoginFailure(token, e, request, response);
    }
}
