package com.lhy.driver.pojo;

/**
 * Created by lhy on 2017/3/12.
 */
public class Dictionary {
    //ID
    private Long id;
    //字典名称
    private String name;
    //字典编码值
    private String code;
    //字典描述
    private String descs;

    public Dictionary() {
    }

    public Dictionary(Long id, String name, String code, String descs) {
        this.id = id;
        this.name = name;
        this.code = code;
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescs() {
        return descs;
    }

    public void setDescs(String descs) {
        this.descs = descs;
    }
}
