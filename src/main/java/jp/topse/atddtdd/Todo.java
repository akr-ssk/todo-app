package jp.topse.atddtdd;

public class Todo {
    private long id;
    private String title;
    private int priority;
    private String status;
    private String deadline; //(example: 2020-01-18)
    private String deadlineNotificationMessage;
    private static final TodoIndexHolder todoIndexHolder = TodoIndexHolder.getInstance();

    //used from Parser.
    Todo() {}

    @Deprecated
    public Todo(String title) {
        this(title, 3, "");
    }

    public Todo(String title, int priority, String deadline) {
        this(todoIndexHolder.getId(), title, priority, deadline);
    }

    public Todo(long id, String title, int priority, String deadline) {
        this(id, title, priority, "TODO", deadline);
    }

    public Todo(long id, String title, int priority, String status, String deadline) {
        this.id = id;
        this.title = title;
        if(priority <= 0 || priority > 5) {
            throw new IllegalArgumentException("priority is not in range.");
        }
        this.priority = priority;
        this.status = status;
        this.deadline = deadline;
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

    public String getDeadline() {
        return this.deadline;
    }

    public void setDeadline(String date) {
        this.deadline = date;
    }

    public String getDeadlineNotificationMessage() {
        return deadlineNotificationMessage;
    }

    public void setDeadlineNotificationMessage(String deadlineNotificationMessage) {
        this.deadlineNotificationMessage = deadlineNotificationMessage;
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
