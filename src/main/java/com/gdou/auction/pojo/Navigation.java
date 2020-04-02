package com.gdou.auction.pojo;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/1 - 15:56
 */
public class Navigation {
    private Integer navigationId;
    private String navigationName;
    private String url;
    private List<Permission> childNavigations;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getNavigationId() {
        return navigationId;
    }

    public void setNavigationId(Integer navigationId) {
        this.navigationId = navigationId;
    }

    public String getNavigationName() {
        return navigationName;
    }

    public void setNavigationName(String navigationName) {
        this.navigationName = navigationName;
    }

    public List<Permission> getChildNavigations() {
        return childNavigations;
    }

    public void setChildNavigations(List<Permission> childNavigations) {
        this.childNavigations = childNavigations;
    }
}
