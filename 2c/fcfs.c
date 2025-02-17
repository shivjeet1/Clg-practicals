#include<stdio.h>

int main ()
{
	int n=0;
	float sum1=0;
	float sum2=0;
	printf("Enter the number of processes: ");
	scanf("%d", &n);
	int atbt[n][2], CT[n],TAT[n],WT[n];
	
	for(int i=0; i<n; i++){
		printf("Enter the Arrival Time for Process %d: ",i);
		scanf("%d", &atbt[i][0]);
	}

	printf("\n");
	for(int i=0; i<n; i++){
		printf("Enter the Burst Time for Process %d: ",i);
		scanf("%d", &atbt[i][1]);
	}
	
	printf("\nEntered data is :\nAT\tBT\n");
        for(int i=0; i<n; i++){
                printf("%d\t%d\n", atbt[i][0],atbt[i][1]);
        }

	int temp1, temp2;
	for(int i=0;i<n;i++){
		for(int j=0;j<(n-i-1);j++){
			if(atbt[j][0] > atbt[j+1][0]){
				temp1 = atbt[j][0];
				atbt[j][0] = atbt[j+1][0];
				atbt[j+1][0] = temp1;

				temp2 = atbt[j][1];
				atbt[j][1] = atbt[j+1][1];
				atbt[j+1][1] = temp2;
			}

		}
	}

	CT[0]=0;
	for(int i=0; i<n; i++){
		if(i==0){
			CT[i] = atbt[i][1];
		}else{
			CT[i] = atbt[i][1]+CT[i-1];
		}
	}

	for(int i=0; i<n; i++){
		TAT[i] = CT[i] - atbt[i][0];
		sum1 += TAT[i];
	}

	for(int i=0; i<n; i++){
		WT[i] = TAT[i] - atbt[i][1];
		sum2 += WT[i];
	}

	printf("\nEntered data is :\nAT\tBT\tCT\tTAT\tWT\n");
	for(int i=0; i<n; i++){
		printf("%d\t%d\t%d\t%d\t%d\n", atbt[i][0],atbt[i][1], CT[i], TAT[i], WT[i]);
	}

	printf("Average Turn-Around Time : %2f \nAverage Waiting Time : %2f", (sum1/n), (sum2/n));

	return 0;
}
