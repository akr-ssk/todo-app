package jp.topse.atddtdd;

public class Todo {
    private String title;
    private int priority;

    public Todo(String title) {
        this(title, 3);
    }

    public Todo(String title, int priority) {
        this.title = title;
        if(priority <= 0 || priority > 5) {
            throw new IllegalArgumentException("priority is not in range.");
        }
        this.priority = priority;
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
}
