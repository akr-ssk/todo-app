package jp.topse.atddtdd;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.util.List;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;

public class TodoFileManagerTest {
    private TodoFileManager todoFileManager;
    private File todoFile;

    @Before
    public void before() throws IOException {
        todoFile = File.createTempFile("todo", "tmp");
        todoFileManager = new TodoFileManager(todoFile);
    }

    @After
    public void after() {
        //some tests delete the files
        //and new tests will create new files, so I ignore what to be happened here.
        todoFile.delete();
    }

    @Test
    public void initialTodoIsEmpty() {
        try {
            List<Todo> todos = todoFileManager.readTodos();
            assertThat(todos.size(), is(0));
        } catch (IOException ex) {
            fail();
        }
    }

    @Test
    public void updateTodoEntry() {
        try {
            List<Todo> todos = todoFileManager.readTodos();
            Todo newtodo = new Todo("meet the family at the station");
            List<Todo> afterUpdate = todoFileManager.updateTodo(newtodo);
            assertThat(todos.size(), is(0));
            assertThat(afterUpdate.size(), is(1));
        } catch (IOException ex) {
            fail();
        }
    }

    @Test
    public void readAfterRemovingIsNothing() {
        try {
            List<Todo> todos = todoFileManager.readTodos();
            Todo newtodo = new Todo("meet the family at the station");
            List<Todo> afterUpdate = todoFileManager.updateTodo(newtodo);
            todoFile.delete();
            List<Todo> afterDeletingTodo = todoFileManager.readTodos();

            assertThat(todos.size(), is(0));
            assertThat(afterUpdate.size(), is(1));
            assertThat(afterDeletingTodo.size(), is(0));
        } catch (IOException ex) {
            fail();
        }
    }

}
