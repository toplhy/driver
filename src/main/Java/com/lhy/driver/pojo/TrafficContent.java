package com.lhy.driver.pojo;

/**
 * Created by lhy on 2017/3/6.
 */
public class TrafficContent {

    private Long id;
    private Long tid;
    private String content;

    public TrafficContent() {
    }

    public TrafficContent(Long tid, String content) {
        this.tid = tid;
        this.content = content;
    }

    public TrafficContent(Long id, Long tid, String content) {
        this.id = id;
        this.tid = tid;
        this.content = content;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
