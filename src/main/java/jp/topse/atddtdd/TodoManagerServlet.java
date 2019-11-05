package jp.topse.atddtdd;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/todo"})
public class TodoManagerServlet extends HttpServlet {
    private List<Todo> todoList = new ArrayList<>();

    private final static String KEY_ERROR_MESSAGE = "errorMessage";
    private final static String KEY_TODOS = "todoList";

    private final static String MSG_TITLE_IS_EMPTY = "title should not be empty";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {
        getServletContext().setAttribute(KEY_ERROR_MESSAGE, "");
        String title = req.getParameter("title");
        if(title == null || "".equals(title)) {
            getServletContext().setAttribute(KEY_ERROR_MESSAGE, MSG_TITLE_IS_EMPTY);
        } else {
            registerTodo(title);
            getServletContext().setAttribute(KEY_TODOS, todoList);
        }

        try {
            res.sendRedirect("/index.jsp");
        } catch (IOException ex) {
            ex.printStackTrace(System.err);
        }

    }

    private void registerTodo(String title) {
        Todo todo = new Todo(title);
        todoList.add(todo);
    }
}
