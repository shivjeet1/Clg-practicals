#include<stdio.h>
int main (){
int n;
printf("Enter no of elements: \n");
scanf("%d", &n);
printf("Enter %d elements: \n");
int a[n];
int largest=0;
	for( int i=0; i<n; i++){
	scanf("%d", &a[i]);
	}
printf("Entered array is : \n");
	for(int i=0; i<n; i++) {
	printf("%d \n", a[i]);
	}
	for (int i=1; i<n; i++) {
	if(a[i]>largest){
		largest = a[i];
		}
	}
printf("The largest element is %d .", largest);
return 0;
}
