<%@ page import="jp.topse.atddtdd.TodoFileManager" %>
<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    TodoFileManager fileManager = new TodoFileManager();
    session.setAttribute("todoList", fileManager.readTodos());
%>

<html lang="ja">
<head>
    <title>TODO App</title>
    <meta charset="utf-8">
</head>
<body>
    <h1>ToDo App</h1>
    <p id="error-Message">${sessionScope.errorMessage}</p>
    <form action="./todo" method="POST" id="todo-add">
        <p>Title: <input type="text" id="title" name="title" /></p>
        <p>Priority:
            <select id="priority" name="priority">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3" selected>3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </p>
        <p>期限: <input type="date" name="deadline" /></p>
        <input type="submit" value="ADD" />
    </form>
    <hr />
    <table>
        <thead>
            <tr>
                <th>id:</th>
                <th>title:</th>
                <th>priority:</th>
                <th>status:</th>
                <th>limit:</th>
                <th>期限切れ？</th>
                <th><!-- button --></th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.todoList}" var="todo" varStatus="status">
            <form action="./todo" method="POST" id="todo-update-${status.index}">
            <tr>
                <td>
                    <input name="id" type="text" value="${todo.id}" readonly="readonly"/>
                </td>
                <td>
                    <input name="title" type="text" value="${todo.title}" /><br />
                </td>
                <td>
                    <select name="priority">
                        <option value="1" ${todo.priority == 1 ? "selected" : ""}>1</option>
                        <おoption value="2" ${todo.priority == 2 ? "selected" : ""}>2</おoption>
                        <option value="3" ${todo.priority == 3 ? "selected" : ""}>3</option>
                        <option value="4" ${todo.priority == 4 ? "selected" : ""}>4</option>
                        <option value="5" ${todo.priority == 5 ? "selected" : ""}>5</option>
                    </select>
                </td>
                <td>
                    <select name="status">
                        <option value="TODO" ${todo.status == 'TODO' ? "selected" : ""}>TODO</option>
                        <option value="CLOSE" ${todo.status == 'CLOSE' ? "selected" : ""}>CLOSE</option>
                    </select>
                </td>
                <td>
                    <input name="deadline" type="date" value="${todo.deadline}" />
                </td>
                <td>
                    <p style="color: red; font-weight: bold;">${todo.deadlineNotificationMessage}</p>
                </td>
                <td>
                    <input type="submit" value="UPDATE" />
                </td>
            </tr>
            </form>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>
