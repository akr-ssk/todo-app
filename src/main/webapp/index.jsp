<%@ page import="jp.topse.atddtdd.TodoFileManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    TodoFileManager fileManager = new TodoFileManager();
    session.setAttribute("todoList", fileManager.readTodos());

    List<Integer> priorities = Arrays.asList(1, 2, 3, 4, 5);
%>

<html lang="ja">
<head>
    <title>TODO App</title>
    <meta charset="utf-8">
</head>
<body>
    <h1>ToDo App</h1>
    <p id="error-Message">${sessionScope.errorMessage}</p>
    <form action="./todo" method="POST">
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
        <input type="submit" value="ADD" />
    </form>
    <hr />
    <table>
        <thead>
            <tr>
                <th>title:</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.todoList}" var="todo" >
            <tr>
                <td>
                    <c:out value="${todo.title}" />
                    <select>
                        <option value="1" selected="${todo.priority == 1 ? "selected" : ""}">1</option>
                        <option value="2" selected="${todo.priority == 2 ? "selected" : ""}">2</option>
                        <option value="3" selected="${todo.priority == 3 ? "selected" : ""}">3</option>
                        <option value="4" selected="${todo.priority == 4 ? "selected" : ""}">4</option>
                        <option value="5" selected="${todo.priority == 5 ? "selected" : ""}">5</option>
                        <option value="0" selected="${todo.priority == null? "selected" : ""}"></option>
                    </select>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>
