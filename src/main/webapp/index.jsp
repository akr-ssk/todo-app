<%@ page import="jp.topse.atddtdd.TodoFileManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    TodoFileManager fileManager = new TodoFileManager();
    session.setAttribute("todoList", fileManager.readTodos());
%>

<html lang="ja">
<head>
    <title>TODO App</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>ToDo App</h1>
    <p id="error-Message">${sessionScope.errorMessage}</p>
    <form action="./todo" method="POST">
        <p>Title: <input type="text" id="title" name="title" /></p>
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
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>
