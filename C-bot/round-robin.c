#include <stdio.h>

int main() {
    int n = 0;
    float sum1 = 0;
    float sum2 = 0;
    
    printf("Enter the number of processes: ");
    scanf("%d", &n);
    
    int atbt[n][2], CT[n], TAT[n], WT[n], completed[n];
   for (int i = 0; i < n; i++) {
        printf("Enter the Arrival Time for Process %d: ", i);
        scanf("%d", &atbt[i][0]);
        completed[i] = 0;  // Initialize completed flag
    }
    
    printf("\n");
    for (int i = 0; i < n; i++) {
        printf("Enter the Burst Time for Process %d: ", i);
        scanf("%d", &atbt[i][1]);
    }
    
    printf("\nEntered data is :\nAT\tBT\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t%d\n", atbt[i][0], atbt[i][1]);
    }
   int time = 0, completed_count = 0;

    while (completed_count < n) {
        int min_bt = 1e9;         int idx = -1;
        for (int i = 0; i < n; i++) {
            if (!completed[i] && atbt[i][0] <= time && atbt[i][1] < min_bt) {
                min_bt = atbt[i][1];
                idx = i;
            }
        }

        if (idx == -1) {
	time++;         
	} else {
		time += atbt[idx][1];
		CT[idx] = time;
		TAT[idx] = CT[idx] - atbt[idx][0];
		WT[idx] = TAT[idx] - atbt[idx][1];
		sum1 += TAT[idx];
sum2 += WT[idx];

            completed[idx] = 1;  
            completed_count++;
        }
    }

    printf("\nEntered data is :\nAT\tBT\tCT\tTAT\tWT\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t%d\t%d\t%d\t%d\n", atbt[i][0], atbt[i][1], CT[i], TAT[i], WT[i]);
    }

    printf("Average Turn-Around Time : %.2f \nAverage Waiting Time : %.2f\n", (sum1 / n), (sum2 / n));

    return 0;
}

