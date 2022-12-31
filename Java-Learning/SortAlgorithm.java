import java.util.Arrays;


public class SortAlgorithm {

    public void quickSort(int[] nums, int start, int end) {
        if (start < end) {
            int pivotIndex = getPivotIndex(nums, start, end);
            quickSort(nums, start, pivotIndex - 1);
            quickSort(nums, pivotIndex + 1, end);
        }
    }

    public int getPivotIndex(int[] nums, int start, int end) {
        int pivot = nums[start];
        int low = start;
        int high = end;
        while (low < high) {
            while (low <= high && nums[low] <= pivot)
                low++;
            while (low <= high && nums[high] > pivot)
                high--;
            if (low < high)
                swap(nums, low, high);
        }
        swap(nums, start, high);
        return high;
    }

    public void swap(int[] nums, int start, int end) {
        if (start != end) {
            nums[start] = nums[start] ^ nums[end];
            nums[end] = nums[start] ^ nums[end];
            nums[start] = nums[start] ^ nums[end];
        }
    }
}


class Various {
    public static void main(String[] args) {
        int a = 3, b = 5;
        a = a ^ b;
        b = a ^ b;
        a = a ^ b;
        System.out.println(a);
        System.out.println(b);

        int[] nums = new int[] {9, 5, 1, 3, 8, 7, 6, 2};
        SortAlgorithm sort = new SortAlgorithm();
        sort.quickSort(nums, 0, nums.length - 1);
        System.out.println(Arrays.toString(nums));
    }
}