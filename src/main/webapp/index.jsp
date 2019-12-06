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
    <form action="./todo" method="POST">
        <p>Title: <input type="text" id="title" name="title" /></p>
        <p>メモ: <input type="text" id="memo" name="memo" /></p>
        <!-- tentative -->
        <p>優先度: <input type="text" id="priority" name="priority" /></p>
        <p>期限: <input type="text" id="limit" name="limit" /></p>
        <p>ID: <input type="text" id="todo-id" name="todo-id" /></p>
        <input type="submit" value="ADD" />
    </form>
    <hr />
    <table>
        <thead>
            <tr>
                <th>title</th>
                <th>メモ</th>
                <th>優先度</th>
                <th>作成日</th>
                <th>期限</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.todoList}" var="todo" >
            <tr>
                <td>
                    <c:out value="${todo.title}" />
                    <c:out value="${todo.memo}" />
                    <c:out value="${todo.priority}" />
                    <c:out value="${todo.createsAt}" />
                    <c:out value="${todo.whenToBeDone}" />
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>
