package jp.topse.atddtdd;

public interface Parser {

    public Todo makeTodo(String line);

    public String convertToString(Todo todo);
}
