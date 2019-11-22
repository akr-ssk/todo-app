package jp.topse.atddtdd;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/todo"})
public class TodoManagerServlet extends HttpServlet {
    //private List<Todo> todoList = Collections.synchronizedList(new ArrayList<>());

    private final static String KEY_ERROR_MESSAGE = "errorMessage";
    private final static String KEY_TODOS = "todoList";

    private final static String MSG_TITLE_IS_EMPTY = "タスク名は空にできません";
    private final static String MSG_TITLE_INVALID_STRING = "入力できない文字がセットされています";

    private final static String TODO_FILE_NAME = "ToDo.txt";
    private final static int[] lock = new int[0];

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {
        getServletContext().setAttribute(KEY_ERROR_MESSAGE, "");
        String title = req.getParameter("title");
        if("".equals(title)) {
            getServletContext().setAttribute(KEY_ERROR_MESSAGE, MSG_TITLE_IS_EMPTY);
        } else if(";".contains(title)) {
            getServletContext().setAttribute(KEY_ERROR_MESSAGE, MSG_TITLE_INVALID_STRING);
        } else {
            synchronized (lock) {
                //read from todo
                try {
                    File todoFile = new File(TODO_FILE_NAME);
                    if(!todoFile.exists()) {
                        todoFile.createNewFile();
                    }
                    List<String> todos = Files.readAllLines(todoFile.toPath());
                    List<Todo> todoList = new ArrayList<>();
                    // add todo
                    for(String line : todos) {
                        todoList.add(new Todo(line));
                    }
                    todoList.add(new Todo(title));
                    // set current toto
                    BufferedWriter bw = Files.newBufferedWriter(todoFile.toPath(),
                            StandardOpenOption.TRUNCATE_EXISTING);
                    for(Todo todo : todoList) {
                        bw.write(todo.getTitle() + "\r\n");
                    }
                    bw.close();
                    getServletContext().setAttribute(KEY_TODOS, todoList);
                } catch (IOException ex) {
                    res.setStatus(500);
                }
            }
        }
        try {
            res.sendRedirect("/index.jsp");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}
