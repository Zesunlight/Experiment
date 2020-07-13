import java.util.*;

public class DataStructure {
    public static void main(String[] args) {

        // -------------------- List --------------------
        List<Integer> num_list = new ArrayList<>();
        List<String> str_list = new LinkedList<>();

        num_list.add(3);  // add(Integer e)
        num_list.add(1, 5);  // add(int index, Integer element)

        num_list.sort(Integer::compareTo);  // 类名::方法名
        Collections.sort(num_list);
        num_list.sort(new Comparator<Integer>() {
            @Override
            public int compare(Integer o1, Integer o2) {
                // 返回值为int类型，大于0表示正序，小于0表示逆序
                // 实现逆序排序
                return o2 - o1;
            }
        });

        // size(), isEmpty(), toString(), indexOf(Object o), lastIndexOf(Object o)
        // subList(int fromIndex, int toIndex), contains(Object o)
        // get(int index), set(int index, Integer element), clear()

        Integer[] num = num_list.toArray(new Integer[] {});
        Arrays.sort(num);

        num_list.remove(0);  // remove(int index)
        num_list.remove(Integer.valueOf(5));  // remove(Object o)


        // -------------------- Map --------------------
        Map<Integer, String> map = new HashMap<>();
        map.put(3, "three");
        map.put(1, "one");

        Collection<String> value = map.values();
        for (String s: value) System.out.println(s);

        // isEmpty(), size(), containsKey(), containsValue()
        // get(), getOrDefault(), put(), clear()

        String remove = map.remove(3);  // three (同时会改变 value)
        boolean success = map.remove(2, "one");  // false
        for (Integer key : map.keySet()) {
            System.out.print(key);
            System.out.print(map.get(key));
        }


        // -------------------- Set --------------------
        Set<String> set = new HashSet<>();
        set.add("you");
        set.add("she");
        if (set.contains("she")) System.out.println(set.toString());;

        // isEmpty(), size(), contains(), toArray(), clear()

        set.remove("they");  // false

        Set<Integer> set_2 = new TreeSet<>(new Comparator<Integer>() {
            @Override
            public int compare(Integer o1, Integer o2) {
                return o2 - o1;
            }
        });
        // HashSet是无序的，因为它实现了Set接口，并没有实现SortedSet接口；
        // TreeSet是有序的，因为它实现了SortedSet接口，可自定义排序


        // -------------------- Stack --------------------
        Stack<Integer> stack = new Stack<>();
        stack.push(4);
        stack.push(3);
        int top = stack.peek();  // 获取栈顶的值
        top = stack.pop();  // 获取栈顶的值并弹出
        System.out.println(stack.empty());

        Deque<Integer> stack_2 = new ArrayDeque<>();
        // ArrayDeque 可以作为栈来使用，效率要高于 Stack
        // LinkedList 也可以用来实现栈
        // peek(), pop(), push(), isEmpty()


        // -------------------- Queue --------------------
        Queue<Integer> queue = new LinkedList<>();
        //                  throw Exception	    返回false或null
        // 添加元素到队尾	    add(E e)	        boolean offer(E e)
        // 取队首元素并删除	E remove()	        E poll()
        // 取队首元素但不删除	E element()	        E peek()


        // -------------------- Deque --------------------
        Deque<Integer> deque = new LinkedList<>();
        // 将元素添加到队尾或队首：addLast()/offerLast()/addFirst()/offerFirst()；
        // 从队首／队尾获取元素并删除：removeFirst()/pollFirst()/removeLast()/pollLast()；
        // 从队首／队尾获取元素但不删除：getFirst()/peekFirst()/getLast()/peekLast()；


        // -------------------- PriorityQueue --------------------
        Queue<User> prq = new PriorityQueue<>(new UserComparator());  // 默认实现了最小堆
        Queue<User> prq2 = new PriorityQueue<>(Comparator.comparing(User::getName)
                .thenComparing(User::getNumber, (s, t) -> {
                    return Integer.compare(s.length(), t.length());
                }));
        Queue<User> prq3 = new PriorityQueue<>(Comparator.comparing(User::getName, (s, t) -> Integer.compare(s.length(), t.length()))
                .thenComparing(User::getNumber, Comparator.comparingInt(String::length)));
        // 或者提供 Comparator 对象来判断两个元素的顺序，里面重载 compare() 函数

        // 调用remove()或poll()方法，返回的总是优先级最高的元素
        // 可以用 remove(Object o) 来删除与给定对象相同的最先出队的对象
    }
}


class UserComparator implements Comparator<User> {
    @Override
    public int compare(User u1, User u2) {
        if (u1.number.charAt(0) == u2.number.charAt(0)) {
            // 如果两人的号都是A开头或者都是V开头,比较号的大小:
            return u1.number.compareTo(u2.number);
        }
        if (u1.number.charAt(0) == 'V') {
            // u1的号码是V开头,优先级高:
            return -1;
        } else {
            return 1;
        }
    }
}

class User {
    public final String name;
    public final String number;

    public User(String name, String number) {
        this.name = name;
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public String getNumber() {
        return number;
    }

    public String toString() {
        return name + "/" + number;
    }
}