package jp.topse.atddtdd;

import java.util.concurrent.atomic.AtomicLong;

public class TodoIndexHolder {
    private static final TodoIndexHolder SINGLETON = new TodoIndexHolder();

    private TodoIndexHolder() {
    }

    public static TodoIndexHolder getInstance() {
        return SINGLETON;
    }

    private AtomicLong atomicLong = new AtomicLong(0);

    // only be called from single thread.
    public void setCurrentIndex(long value) {
        atomicLong.set(value);
    }

    public synchronized long getId() {
        return atomicLong.getAndIncrement();
    }
}
