package jp.topse.atddtdd;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ResourceBundle;

@WebServlet(urlPatterns = {"/todo"})
public class TodoManagerServlet extends HttpServlet {

    private final static String KEY_ERROR_MESSAGE = "errorMessage";
    private final static String KEY_TODOS = "todoList";
    private static String MSG_TITLE_IS_EMPTY;
    private static String MSG_TITLE_INVALID_STRING;

    static {
        ResourceBundle resourceBundle = ResourceBundle.getBundle("Messages");
        MSG_TITLE_IS_EMPTY = resourceBundle.getString("MSG_TITLE_IS_EMPTY");
        MSG_TITLE_INVALID_STRING = resourceBundle.getString("MSG_TITLE_INVALID_STRING");
    }

    private TodoFileManager todoFileManager = new TodoFileManager();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) {
        HttpSession session = req.getSession(true);
        session.setAttribute(KEY_ERROR_MESSAGE, "");
        try {
            session.setAttribute(KEY_TODOS, todoFileManager.readTodos());
        } catch (IOException ex) {
            res.setStatus(500);
        }
        try {
            res.sendRedirect("/index.jsp");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {
        HttpSession session = req.getSession(true);
        session.setAttribute(KEY_ERROR_MESSAGE, "");
        String id = req.getParameter("id");
        String title = req.getParameter("title");
        String priority = req.getParameter("priority");
        String status = req.getParameter("status");
        Todo todo;
        if(id == null) {
            todo = new Todo(title, Integer.parseInt(priority));
        } else {
            todo = new Todo(Long.parseLong(id),
                    title, Integer.parseInt(priority), status);
        }
        if(isTodoApplicableToRegister(session, todo)) {
            try {
                todoFileManager.updateTodo(todo);
            } catch (IOException ex) {
                res.setStatus(500);
            }
        }
        try {
            res.sendRedirect("/index.jsp");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    private boolean isTodoApplicableToRegister(HttpSession session, Todo todo) {
        String title = todo.getTitle();
        int priority = todo.getPriority();
        if ("".equals(title)) {
            session.setAttribute(KEY_ERROR_MESSAGE, MSG_TITLE_IS_EMPTY);
            return false;
        } else if (";".contains(title)) {
            session.setAttribute(KEY_ERROR_MESSAGE, MSG_TITLE_INVALID_STRING);
            return false;
        }

        return true;
    }
}
