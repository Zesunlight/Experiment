import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;


public class SingletonPattern {
    public static void main(String[] args) throws NoSuchMethodException, IllegalAccessException, InvocationTargetException, InstantiationException {
        // 利用反射打破单例
        Constructor con = StaticSingleton.class.getDeclaredConstructor();  // 获得构造器
        con.setAccessible(true);  // 设置为可访问
        // 构造两个不同的对象
        StaticSingleton singleton1 = (StaticSingleton) con.newInstance();
        StaticSingleton singleton2 = (StaticSingleton) con.newInstance();
        System.out.println(singleton1.equals(singleton2));  // 验证是否是不同对象

        EnumSingleton e = EnumSingleton.INSTANCE;
    }
}


class LazySingleton {
    // 懒汉模式，线程不安全

    private LazySingleton() {}  // 私有构造函数

    private static LazySingleton instance = null;

    public static LazySingleton getInstance() {
        if (instance == null) {
            instance = new LazySingleton();
        }
        return instance;
    }
}


class DoubleCheckSingleton {
    // 双重检查锁

    private DoubleCheckSingleton(){}

    private volatile static DoubleCheckSingleton instance;
    // volatile修饰符阻止了变量访问前后JVM编译器的指令重排

    public static DoubleCheckSingleton getInstance() {
        if(instance == null) {
            synchronized (DoubleCheckSingleton.class) {  // 同步锁
                if (instance == null) {
                    instance = new DoubleCheckSingleton();
                }
            }
        }
        return instance;
    }
}


class HungrySingleton {
    // 饿汉模式，会浪费内存

    private HungrySingleton(){}

    private static final HungrySingleton instance = new HungrySingleton();

    public static HungrySingleton getInstance() {
        return instance;
    }
}


class StaticSingleton {
    // 静态内部类，同时解决饿汉式的内存浪费问题和懒汉式的线程安全问题

    private StaticSingleton(){}

    public static StaticSingleton getInstance() {
        return StaticClass.instance;
    }

    private static class StaticClass {
        private static final StaticSingleton instance = new StaticSingleton();
    }

    // INSTANCE对象初始化的时机并不是在单例类Singleton被加载的时候，
    // 而是在调用getInstance方法使得静态内部类StaticClass被加载的时候。
    // 因此这种实现方式是利用classloader的加载机制来实现懒加载，并保证构建单例的线程安全。
}


enum EnumSingleton {
    // 用枚举实现单例模式可以避免多线程同步问题，还能防止反序列化重新创建新的对象，
    // 绝对防止多次实例化，也能防止反射破解单例的问题
    // 对象是在枚举类被加载的时候进行初始化的，非懒加载
    INSTANCE;

    EnumSingleton() {
        System.out.println("Enum Singleton");
    }
}