package jp.topse.atddtdd;

import java.util.Date;

public class SimpleParser implements Parser{
    private final static String SP = ",";

    @Override
    public Todo makeTodo(String line) {
        String[] task = line.trim().split(SP);
        if(task.length != 4) {
            throw new RuntimeException("csv format is illegal.");
        }
        Todo newTodo = new Todo();
        newTodo.setId(Long.parseLong(task[0]));
        newTodo.setTitle(task[1]);
        newTodo.setPriority(Integer.parseInt(task[2]));
        newTodo.setStatus(task[3]);
        // needs to be refactor.
        //newTodo.setCreatesAt(Date.parse(task[4]));
        //newTodo.setWhenToBeDone(Date.parse(task[5]));

        return newTodo;
    }

    @Override
    public String convertToString(Todo todo) {
        return  todo.getId() + SP +
                todo.getTitle() + SP +
                todo.getPriority() + SP +
                todo.getStatus();
//                todo.getMemo() + SP +
//                todo.getCreatesAt() + SP +
//                todo.getWhenToBeDone();
    }
}
