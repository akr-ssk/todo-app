package jp.topse.atddtdd;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

/**
 *
 */
public class TodoFileManager {
    private final static String TODO_FILE_NAME = "ToDo.csv";
    private File todoFile;
    private Parser parser = new SimpleParser();
    private static final Logger LOGGER = Logger.getLogger(TodoFileManager.class.getName());
    private boolean initialized = false;
    private TodoIndexHolder todoIndexHolder = TodoIndexHolder.getInstance();

    public TodoFileManager() {
        this(new File(TODO_FILE_NAME));
        initializeIndex();
    }

    public TodoFileManager(File file) {
        this.todoFile = file;
    }

    private void initializeIndex() {
        try {
            List<Todo> todos = readTodos();
            todoIndexHolder.setCurrentIndex(todos.size());
        } catch (IOException ex) {
            throw new RuntimeException(ex);
        }
        this.initialized = true;
    }

    public synchronized List<Todo> readTodos() throws IOException {
        if (!todoFile.exists()) {
            todoFile.createNewFile();
        }
        List<String> todos = Files.readAllLines(todoFile.toPath());
        List<Todo> todoList = new ArrayList<>();
        for (String line : todos) {
            todoList.add(parser.makeTodo(line));
        }
        return todoList;
    }

    synchronized List<Todo> updateTodo(Todo todo) throws IOException {
        List<Todo> todoList = this.readTodos();
        //care for update:
        if(!todoList.contains(todo)) {
            todoList.add(todo);
        } else {
            LOGGER.info("updating same task. id = " + todo.getId());
            Optional<Todo> before = todoList.stream()
                    .filter(x -> x.getId() == todo.getId()).findFirst();
            if(before.isPresent()) {
                int index = todoList.indexOf(before.get());
                todoList.remove(index);
                todoList.add(index, todo);
            }
        }
        BufferedWriter bw = Files.newBufferedWriter(todoFile.toPath(),
                StandardOpenOption.TRUNCATE_EXISTING);
        for (Todo task : todoList) {
            bw.write(parser.convertToString(task) + "\r\n");
        }
        bw.close();
        return todoList;
    }
}
