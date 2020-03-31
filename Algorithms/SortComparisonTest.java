import org.junit.Test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
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

    public static void main(String[] args) throws IOException {
        double startTime = System.currentTimeMillis();
        File file = new File("C:\\Users\\oisin\\Documents\\" +
                "CollegeOld\\Second-Year\\Algorithms and Data Structures" +
                "\\Algorithms and Data Structures\\Semester2\\src\\numbersSorted1000.txt");
        BufferedReader br = new BufferedReader(new FileReader(file));
        String st;
        double [] tester = new double [1000];
        double [] sorted;// = new double [10];
        int index = 0;
        double number=0;
        while ((st = br.readLine()) != null) {
            number = Double.valueOf(st);
            tester[index++] = number;
        }
        sorted = SortComparison.quickSort(tester, 0, tester.length-1);
        for(int i=0; i<sorted.length; i++){
            System.out.println(i+1+": "+sorted[i]);
        }
        double endTime = System.currentTimeMillis();
        double overallTime = endTime-startTime;
        System.out.println("Runtime: "+overallTime);
    }
}