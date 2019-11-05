<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>TODO App</title>
</head>
<body>
    <h1>ToDo App</h1>
    <p>${applicationScope.errorMessage}</p>
    <form action="./todo" method="POST">
        <p>Title: <input type="text" name="title" /></p>
        <input type="submit" value="register" />
    </form>
    <hr />
    <table>
        <thead>
            <tr>
                <th>title:</th>
            </tr>
        </thead>
        <c:forEach items="${applicationScope.todoList}" var="todo" >
            <tr>
                <td>
                    <c:out value="${todo.title}" />
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
