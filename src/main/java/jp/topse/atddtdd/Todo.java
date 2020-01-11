package jp.topse.atddtdd;

import java.util.concurrent.atomic.AtomicLong;

public class Todo {
    private long id;
    private String title;
    private int priority;
    private String status;
    private static final TodoIndexHolder todoIndexHolder = TodoIndexHolder.getInstance();

    //used from Parser.
    Todo() {}

    @Deprecated
    public Todo(String title) {
        this(title, 3);
    }

    public Todo(String title, int priority) {
        this(todoIndexHolder.getId(), title, priority);
    }

    public Todo(long id, String title, int priority) {
        this(id, title, priority, "TODO");
    }

    public Todo(long id, String title, int priority, String status) {
        this.id = id;
        this.title = title;
        if(priority <= 0 || priority > 5) {
            throw new IllegalArgumentException("priority is not in range.");
        }
        this.priority = priority;
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }

    @Override
    public boolean equals(Object obj) {
        // should be critical for updating Todo task.
        if(obj instanceof Todo) {
            return this.getId() == ((Todo) obj).id;
        }
        return false;
    }
}
