import org.junit.Test;

import java.util.Arrays;

import static org.junit.Assert.*;

public class SortComparisonTest {
        @Test
        public void testInsertionSort(){
            double toSort[] = {7,1,3,5,8,2,4,6,9};
            double correctArr[] = {1,2,3,4,5,6,7,8,9};
            assertTrue(Arrays.equals(correctArr,SortComparison.insertionSort(toSort)));
        }
    @Test
    public void testSelectionSort(){
        double toSort[] = {7,1,3,5,8,2,4,6,9};
        double correctArr[] = {1,2,3,4,5,6,7,8,9};
        assertTrue(Arrays.equals(correctArr,SortComparison.selectionSort(toSort)));
    }
    @Test
    public void testQuickSort(){
        double toSort[] = {7,1,3,5,8,2,4,6,9};
        double correctArr[] = {1,2,3,4,5,6,7,8,9};
        assertTrue(Arrays.equals(correctArr,SortComparison.quickSort(toSort, 0, toSort.length-1)));
    }
    @Test
    public void testMergeSortRecurssive(){
        double toSort[] = {7,1,3,5,8,2,4,6,9};
        double correctArr[] = {1,2,3,4,5,6,7,8,9};
        assertTrue(Arrays.equals(correctArr,SortComparison.mergeSortRecursive(toSort)));
    }
    @Test
    public void testMergeSortIterative(){
        double toSort[] = {7,1,3,5,8,2,4,6,9};
        double correctArr[] = {1,2,3,4,5,6,7,8,9};
        assertTrue(Arrays.equals(correctArr,SortComparison.mergeSortIterative(toSort)));
    }
}