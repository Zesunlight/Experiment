import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class ArraysUsage {

    public static void main(String[] args) {

        // create array
        String[] str_array = {"一", "朵", "深", "渊"};
        String[] str_array_2 = new String[] {"一", "朵", "深", "渊"};
        String[] str_array_3 = new String[4];
        Arrays.fill(str_array_3, "深渊"); // {"深渊", "深渊", "深渊", "深渊"}
        String[][] str_array_4 = {{"一"}, {"朵"}, {"深"}, {"渊"}};

        int[] number = new int[10];
        Arrays.setAll(number, i -> i + 1); // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        String monday = new String("Monday");
        char[] char_monday = monday.toCharArray();

        String[] copy_of_str_array = Arrays.copyOf(str_array, 2);   // {"一", "朵"}
        String[] copy_of_str_array_2 = Arrays.copyOf(str_array_2, 6);   // {"一", "朵", "深", "渊", null, null}
        String[] copy_of_str_array_3 = Arrays.copyOfRange(str_array_2, 1, 3);   // {"朵", "深"}
        String[] copy_of_str_array_4 = Arrays.copyOfRange(str_array_3, 2, 5);   // {"深渊", "深渊", null}


        // equal or not
        boolean equal = Arrays.equals(copy_of_str_array_4, new String[] {"深渊", "深渊"});  // false
        boolean equal_2 = Arrays.hashCode(str_array) == Arrays.hashCode(str_array_2);  // true (不严谨)
        boolean equal_3 = monday.charAt(monday.length() - 1) == char_monday[char_monday.length - 1];  // true


        // search and sort
        String[] week = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        // array 无 contains、indexOf 方法
        System.out.println(Arrays.asList(week).indexOf("Friday"));  // 4
        System.out.println(Arrays.asList(week).indexOf("friday"));  // -1 (不存在，返回 -1)
        Arrays.sort(week);  // [Friday, Monday, Saturday, Sunday, Thursday, Tuesday, Wednesday]
        System.out.println(Arrays.binarySearch(week, "monday", String::compareToIgnoreCase));   // 1
        System.out.println(Arrays.binarySearch(week, "sunday"));   // -8 (如果没找到，返回负值)


        // others
        System.out.println(Arrays.toString(week));

        List<String> list_week = Arrays.asList(week);
        // Arrays.asList() 返回的是 java.util.Arrays.ArrayList，不是 java.util.ArrayList，它的长度是固定的，无法进行元素的删除或者添加
        List<String> list_week_2 = new ArrayList<>(Arrays.asList(week));
        list_week.add("weekend"); // java.lang.UnsupportedOperationException
        list_week_2.add("weekend"); // no problem
        list_week_2.remove("weekend"); // no problem

        // parallelPrefix() 方法和 setAll() 方法是 Java 8 之后提供的，提供了一个函数式编程的入口
        // parallelPrefix() 通过遍历数组中的元素，将当前下标位置上的元素与它之前下标的元素进行操作，然后将操作后的结果覆盖当前下标位置上的元素
        Arrays.parallelPrefix(number, (pre, cur) -> cur - pre); // Lambda 表达式描述了一个代码块（或者叫匿名方法）
        System.out.println(Arrays.toString(number));    // [1, 1, 2, 2, 3, 3, 4, 4, 5, 5]

    }
}
