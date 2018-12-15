package com.lhy.driver.pojo;

import java.util.Date;

/**
 * Created by lhy on 2017/4/29.
 */
public class ExamHistory {
    //ID
    private Long id;
    //用户ID
    private Long user;
    //考试科目
    private Long item;
    //得分
    private double score;
    //开始时间
    private Date begintime;
    //开始时间
    private Date submittime;

    public ExamHistory() {
    }

    public ExamHistory(Long id, Long user, Long item, double score, Date begintime, Date submittime) {
        this.id = id;
        this.user = user;
        this.item = item;
        this.score = score;
        this.begintime = begintime;
        this.submittime = submittime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUser() {
        return user;
    }

    public void setUser(Long user) {
        this.user = user;
    }

    public Long getItem() {
        return item;
    }

    public void setItem(Long item) {
        this.item = item;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public Date getBegintime() {
        return begintime;
    }

    public void setBegintime(Date begintime) {
        this.begintime = begintime;
    }

    public Date getSubmittime() {
        return submittime;
    }

    public void setSubmittime(Date submittime) {
        this.submittime = submittime;
    }
}
