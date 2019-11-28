package jp.topse.atddtdd;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
public class TodoFileManager {
    private final static String TODO_FILE_NAME = "ToDo.csv";
    private File todoFile = new File(TODO_FILE_NAME);

    public synchronized List<Todo> readTodos() throws IOException {
        if (!todoFile.exists()) {
            todoFile.createNewFile();
        }
        List<String> todos = Files.readAllLines(todoFile.toPath());
        List<Todo> todoList = new ArrayList<>();
        for (String line : todos) {
            todoList.add(new Todo(line));
        }
        return todoList;
    }

    synchronized List<Todo> updateTodo(Todo todo) throws IOException {
        List<Todo> todoList = this.readTodos();
        todoList.add(todo);
        BufferedWriter bw = Files.newBufferedWriter(todoFile.toPath(),
                StandardOpenOption.TRUNCATE_EXISTING);
        for (Todo task : todoList) {
            bw.write(task.getTitle() + "\r\n");
        }
        bw.close();
        return todoList;
    }
}
