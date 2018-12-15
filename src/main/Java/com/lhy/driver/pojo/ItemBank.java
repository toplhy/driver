package com.lhy.driver.pojo;

/**
 * Created by lhy on 2017/3/12.
 */
public class ItemBank {
    //ID
    private Long id;
    //题库名称
    private String name;
    //题库对应车型
    private String drivertype;
    //题库描述
    private String descs;
    //题库状态
    private Integer state;
    //题库试卷生成规则
    //单选题数量
    private Integer singnum;
    //单选题分值
    private Double singscore;
    //多选题数量
    private Integer multnum;
    //多选题分值
    private Double multscore;
    //试卷考试时间
    private Integer duration;
    //总分
    private Double totalscore;
    //及格分
    private Double passscore;

    public ItemBank() {
    }

    public ItemBank(Long id, String name, String drivertype, String descs, Integer state, Integer singnum, Double singscore, Integer multnum, Double multscore, Integer duration, Double totalscore, Double passscore) {
        this.id = id;
        this.name = name;
        this.drivertype = drivertype;
        this.descs = descs;
        this.state = state;
        this.singnum = singnum;
        this.singscore = singscore;
        this.multnum = multnum;
        this.multscore = multscore;
        this.duration = duration;
        this.totalscore = totalscore;
        this.passscore = passscore;
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

    public String getDrivertype() {
        return drivertype;
    }

    public void setDrivertype(String drivertype) {
        this.drivertype = drivertype;
    }

    public String getDescs() {
        return descs;
    }

    public void setDescs(String descs) {
        this.descs = descs;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getSingnum() {
        return singnum;
    }

    public void setSingnum(Integer singnum) {
        this.singnum = singnum;
    }

    public Double getSingscore() {
        return singscore;
    }

    public void setSingscore(Double singscore) {
        this.singscore = singscore;
    }

    public Integer getMultnum() {
        return multnum;
    }

    public void setMultnum(Integer multnum) {
        this.multnum = multnum;
    }

    public Double getMultscore() {
        return multscore;
    }

    public void setMultscore(Double multscore) {
        this.multscore = multscore;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Double getTotalscore() {
        return totalscore;
    }

    public void setTotalscore(Double totalscore) {
        this.totalscore = totalscore;
    }

    public Double getPassscore() {
        return passscore;
    }

    public void setPassscore(Double passscore) {
        this.passscore = passscore;
    }

}
