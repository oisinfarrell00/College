// -------------------------------------------------------------------------

import java.io.*;

/**
 *  This class contains static methods that implementing sorting of an array of numbers
 *  using different sort algorithms.
 *
 *  @author
 *  @version HT 2020
 *
 *
 *                          insert  selection   merge recursive merge iterative quick
 *  10 random               39.0ms  66.0ms      53.0ms          56.0ms          69.0ms
 *  100 random              47.0ms  53.0ms      60.0ms          59.0ms          54.0ms
 *  1000 random             141ms   116ms       102ms           105ms           94ms
 *  1000 few unique         138ms   116ms       100ms           85ms            94ms
 *  1000 nearly ordered     116ms   113ms       109ms           96ms            116ms
 *  1000 reversed           122ms   116ms       116ms           100ms           116ms
 *  1000 sorted             110ms   109ms       109ms           94ms            125ms
 *
 *
 *
 *
 *
 *
 *
 */

class SortComparison {

    /**
     * Sorts an array of doubles using InsertionSort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order.
     *
     */
    static double [] insertionSort (double a[]){
        for (int i=1; i<a.length; i++){
            int j=i;
            while(j>0 && a[j]<a[j-1]){
                double temp = a[j-1];
                a[j-1]=a[j];
                a[j]=temp;
                j--;
            }
        }
        return a;
    }

    /**
     * Sorts an array of doubles using Selection Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] selectionSort (double a[]){
        for (int i=0; i<a.length-1; i++) {
            int minIndex = i;
            for(int j=i+1; j<a.length; j++){
                if(a[j]<a[minIndex]) minIndex=j;
            }
            double temp = a[minIndex];
            a[minIndex]=a[i];
            a[i]=temp;
        }
        return a;
    }

    /**
     * Sorts an array of doubles using Quick Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */

    public static int partition(double a[], int p, int r){
        double x = a[r];
        int i = p-1;
        for(int j=p; j<r; j++){
            if(a[j]<=x){
                i++;
                double temp = a[i];
                a[i]=a[j];
                a[j]=temp;
            }

        }
        double temp = a[i+1];
        a[i+1] = a[r];
        a[r]=temp;
        return i+1;
    }

    static double [] quickSort (double a[], int p, int r){
        if(p<r) {
            int q = partition(a, p, r);
            quickSort(a, p, q - 1);
            quickSort(a, q + 1, r);
        }

        return a;
    }//end quicksort

    /**
     * Sorts an array of doubles using Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    /**
     * Sorts an array of doubles using iterative implementation of Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     *
     * @param a: An unsorted array of doubles.
     * @return after the method returns, the array must be in ascending sorted order.
     */

    static double[] mergeSortIterative (double a[]) {
        for(int size=1; size<a.length; size+=size){


            for(int i = 0; i<a.length-size; i+=size+size){
                merge(a, i, i+size-1, Math.min(i+size+size-1, a.length-1));
            }
        }
        return a;
    }//end mergesortIterative

    /**
     * Sorts an array of doubles using recursive implementation of Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     *
     * @param a: An unsorted array of doubles.
     * @return after the method returns, the array must be in ascending sorted order.
     */
    static double[] mergeSortRecursive (double a[], int p, int r) {
        if(p<r){
            int q=((p+r)/2);
            mergeSortRecursive(a, p, q);
            mergeSortRecursive(a, q+1, r);
            merge(a, p,q,r);
        }

        return a;
    }
    public static void merge(double[] a, int p, int q, int r){
        int n = q-p+1;
        int m = r-q;

        double l[] = new double[n+1];
        double c[] = new double[m+1];

        for (int i=0; i<n; i++){
            l[i]=a[p+i];
        }
        for (int i=0; i<m; i++){
            c[i]=a[q + 1 + i];
        }

        l[n] = Double.POSITIVE_INFINITY;
        c[m] = Double.POSITIVE_INFINITY;

        int i=0, j =0;
        for(int k = p; k<r+1; k++){
            if(l[i]<= c[j]){
                a[k] = l[i++];
            }
            else{
                a[k] = c[j++];
            }
        }
    }
    static double[] mergeSortRecursive (double a[]) {
        return mergeSortRecursive(a, 0, a.length-1);
    }//end mergeSortRecursive







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
        //sorted = mergeSortIterative(tester);
        sorted = quickSort(tester, 0, tester.length-1);
        for(int i=0; i<sorted.length; i++){
            System.out.println(i+1+": "+sorted[i]);
        }
        double endTime = System.currentTimeMillis();
        double overallTime = endTime-startTime;
        System.out.println("Runtime: "+overallTime);
    }


}//end class

