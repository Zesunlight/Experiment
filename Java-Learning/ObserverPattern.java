import java.util.*;


//观察者
interface Observer {
    public void update();
}


//被观察者
abstract class Subject {
    private final List<Observer> observerList = new ArrayList<Observer>();

    public void attachObserver(Observer observer) {
        observerList.add(observer);
    }

    public void detachObserver(Observer observer){
        observerList.remove(observer);
    }

    public void notifyObservers(){
        for (Observer observer: observerList){
            observer.update();
        }
    }
}


//怪物
class Monster implements Observer {
    @Override
    public void update() {
        if(inRange()){
            System.out.println("怪物 对主角攻击！");
        }
    }

    private boolean inRange(){
        //判断主角是否在自己的影响范围内，这里忽略细节，直接返回true
        return true;
    }
}

//陷阱
class Trap implements Observer {
    @Override
    public void update() {
        if(inRange()){
            System.out.println("陷阱 困住主角！");
        }
    }

    private boolean inRange(){
        //判断主角是否在自己的影响范围内，这里忽略细节，直接返回true
        return true;
    }
}

//宝物
class Treasure implements Observer {
    @Override
    public void update() {
        if(inRange()){
            System.out.println("宝物 为主角加血！");
        }
    }

    private boolean inRange(){
        //判断主角是否在自己的影响范围内，这里忽略细节，直接返回true
        return true;
    }
}


class Hero extends Subject{
    void move(){
        System.out.println("主角向前移动");
        notifyObservers();
    }
}


public class ObserverPattern {
    public static void main(String[] args) {
        //初始化对象
        Hero hero = new Hero();
        Monster monster = new Monster();
        Trap trap = new Trap();
        Treasure treasure = new Treasure();
        //注册观察者
        hero.attachObserver(monster);
        hero.attachObserver(trap);
        hero.attachObserver(treasure);
        //移动事件
        hero.move();
    }
}

