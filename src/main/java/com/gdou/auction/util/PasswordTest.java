package com.gdou.auction.util;

import com.gdou.auction.pojo.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/**
 * @author hua
 * @date 2020/3/24 - 15:08
 */
@RunWith(JUnit4.class)
public class PasswordTest {

    @Test
    public void test(){
        User user = new User();
        user.setPassword("123456");
        PasswordHelper passwordHelper = new PasswordHelper();
        passwordHelper.encryptPassword(user);
        System.out.println(user.getSalt());
        System.out.println(user.getPassword());
    }
}
