package com.lhy.driver.pojo;

/**
 * Created by lhy on 2017/3/6.
 */
public class TrafficMenu {

    private Long id;
    private String name;
    private Long pid;

    public TrafficMenu() {
    }

    public TrafficMenu(String name, Long pid) {
        this.name = name;
        this.pid = pid;
    }

    public TrafficMenu(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public TrafficMenu(Long id, String name, Long pid) {
        this.id = id;
        this.name = name;
        this.pid = pid;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }
}
