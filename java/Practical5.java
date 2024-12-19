import java.util.Scanner;

public class Practical5 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Take input for the array size
        System.out.print("Enter the number of elements: ");
        int n = scanner.nextInt();
        int[] array = new int[n];

        // Input array elements
        System.out.println("Enter the elements:");
        for (int i = 0; i < n; i++) {
            array[i] = scanner.nextInt();
        }

        // Print the original array
        System.out.println("Original Array:");
        printArray(array);

        // Sort the array using bubble sort
        bubbleSort(array);

        // Print the sorted array
        System.out.println("Sorted Array:");
        printArray(array);

        // Close the scanner
        scanner.close();
    }

    // Bubble sort algorithm
    public static void bubbleSort(int[] array) {
        int n = array.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - 1 - i; j++) {
                if (array[j] > array[j + 1]) {
                    // Swap
                    int temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                }
            }
        }
    }

    // Method to print the array
    public static void printArray(int[] array) {
        for (int num : array) {
            System.out.print(num + " ");
        }
        System.out.println();
    }
}
