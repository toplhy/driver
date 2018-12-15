package com.lhy.driver.pojo;

/**
 * Created by lhy on 2017/3/18.
 */
public class Point {
    private Long id;
    private String name;
    private Long ibid;
    private String descs;

    public Point() {
    }

    public Point(Long id, String name, Long ibid, String descs) {
        this.id = id;
        this.name = name;
        this.ibid = ibid;
        this.descs = descs;
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

    public Long getIbid() {
        return ibid;
    }

    public void setIbid(Long ibid) {
        this.ibid = ibid;
    }

    public String getDescs() {
        return descs;
    }

    public void setDescs(String descs) {
        this.descs = descs;
    }
}
