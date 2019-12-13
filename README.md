# ToDo App

## How to run

compile and run with maven
Java 8 or above is required.
```
mvn jetty:run
```

access the following URL
```
http://localhost:8080/index.jsp
```

## Debug

If you need to debug the process, specify the following parameter to MAVEN_OPTS
```
-Xdebug -Xrunjdwp:transport=dt_socket,address=8888,server=y,suspend=y
```