package jp.topse.atddtdd;

import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import java.time.Instant;
import java.time.temporal.ChronoUnit;

public class SimpleParser implements Parser{
    private final static String SP = ",";

    @Override
    public Todo makeTodo(String line) {
        String[] task = line.trim().split(SP);
        if(task.length !=  4 && task.length != 5) {
            throw new RuntimeException("csv format is illegal. length = " + task.length);
        }
        Todo newTodo = new Todo();
        newTodo.setId(Long.parseLong(task[0]));
        newTodo.setTitle(task[1]);
        newTodo.setPriority(Integer.parseInt(task[2]));
        newTodo.setStatus(task[3]);
        if(task.length >= 5) {
            try {
                String deadline = task[4].replace("/", "-");
                newTodo.setDeadline(deadline);
                //calculate rest days and warn messages if needed
                Instant now = new Date().toInstant();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
                Instant taskDeadline = sdf.parse(task[4]).toInstant();
                long restInSecs = ChronoUnit.SECONDS.between(now, taskDeadline);
                if(restInSecs < 0) {
                    newTodo.setDeadlineNotificationMessage("期限切れ");
                }
                if(0 <= restInSecs && restInSecs <= TimeUnit.DAYS.toSeconds(3)) {
                    newTodo.setDeadlineNotificationMessage("期限間近");
                }
            } catch (ParseException ex) {
                ex.printStackTrace(System.err);
            }
        }
        return newTodo;
    }

    @Override
    public String convertToString(Todo todo) {
        String deadline = todo.getDeadline() != null ? todo.getDeadline().replace("-", "/") : "";
        return  todo.getId() + SP +
                todo.getTitle() + SP +
                todo.getPriority() + SP +
                todo.getStatus() + SP +
                deadline;
    }
}
