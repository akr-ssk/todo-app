package jp.topse.atddtdd;

import java.util.Date;

public class Todo {
    private String title;
    private long id;
    private String priority;
    private String memo;
    private Date createsAt;
    private Date whenToBeDone;

    public Todo() {
        
    }

    public Todo(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public Date getCreatesAt() {
        return createsAt;
    }

    public void setCreatesAt(Date createsAt) {
        this.createsAt = createsAt;
    }

    public Date getWhenToBeDone() {
        return whenToBeDone;
    }

    public void setWhenToBeDone(Date whenToBeDone) {
        this.whenToBeDone = whenToBeDone;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }
}
