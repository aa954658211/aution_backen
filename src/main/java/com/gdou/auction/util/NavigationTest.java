package com.gdou.auction.util;

import com.gdou.auction.pojo.Navigation;
import com.gdou.auction.pojo.Permission;
import com.gdou.auction.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/1 - 16:50
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class NavigationTest {

    @Autowired
    private UserService userService;

    @Test
    public void test(){
        List<Navigation> admin = userService.getNavigationBar("admin");
        for (Navigation navigation : admin) {
            System.out.println(navigation.getNavigationId()+" " + navigation.getNavigationName());
            List<Permission> childNavigations = navigation.getChildNavigations();
            for (Permission childNavigation : childNavigations) {
                System.out.print(childNavigation.getName()+ " ");
            }
            System.out.println();
        }
    }
}
