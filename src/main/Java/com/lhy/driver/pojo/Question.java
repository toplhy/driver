package com.lhy.driver.pojo;

/**
 * Created by lhy on 2017/3/20.
 */
public class Question {
    private Long id;
    private Long ibid;
    private String content;
    private Long type;
    private String options;
    private String answer;
    private Integer difficulty;
    private String analysis;
    private String point;
    private String keyword;

    public Question() {
    }

    public Question(Long id, Long ibid, String content, Long type, String options, String answer, Integer difficulty, String analysis, String point, String keyword) {
        this.id = id;
        this.ibid = ibid;
        this.content = content;
        this.type = type;
        this.options = options;
        this.answer = answer;
        this.difficulty = difficulty;
        this.analysis = analysis;
        this.point = point;
        this.keyword = keyword;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIbid() {
        return ibid;
    }

    public void setIbid(Long ibid) {
        this.ibid = ibid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getOptions() {
        return options;
    }

    public void setOptions(String options) {
        this.options = options;
    }

    public Long getType() {
        return type;
    }

    public void setType(Long type) {
        this.type = type;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Integer getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(Integer difficulty) {
        this.difficulty = difficulty;
    }

    public String getAnalysis() {
        return analysis;
    }

    public void setAnalysis(String analysis) {
        this.analysis = analysis;
    }

    public String getPoint() {
        return point;
    }

    public void setPoint(String point) {
        this.point = point;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

}
