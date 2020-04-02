package com.gdou.auction.realm;

import com.gdou.auction.pojo.User;
import com.gdou.auction.service.UserService;
import com.gdou.auction.util.PasswordHelper;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author hua
 * @date 2020/3/22 - 10:40
 */
public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordHelper passwordHelper;

    /**
     * 授权方法
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String username = (String) principalCollection.getPrimaryPrincipal();
        System.out.println("这是授权方法"+username);
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        simpleAuthorizationInfo.setRoles(userService.getRolesByUsername(username));
        simpleAuthorizationInfo.setStringPermissions(userService.getPermissionsByUsername(username));
        return simpleAuthorizationInfo;
    }
    /**
     * 认证方法
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = (String) token.getPrincipal();
        User user = userService.getUserByUsername(username);
        if (user == null) {
            throw new UnknownAccountException("用户名或密码错误");
        }
        String credentials =new String((char[]) token.getCredentials()) ;
        SimpleHash simpleHash = new SimpleHash("MD5",credentials,user.getSalt(),2);
        credentials = simpleHash.toHex();
        if (!user.getPassword().equals(credentials)){
            throw new IncorrectCredentialsException("用户名或密码错误");
        }
        SimpleAuthenticationInfo info =
                new SimpleAuthenticationInfo(
                        user.getUsername(),//用户名
                        user.getPassword(),//密码
                        ByteSource.Util.bytes(user.getSalt()),//盐
                        getName());//realm name
        return info;
    }
}
