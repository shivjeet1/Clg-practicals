#include<stdio.h>
int main (){
    int n, value, loc, input;
    int k;
helo:
    printf("Enter no of elements: \n");
    scanf("%d", &n);
    printf("Enter %d elements: \n");
    int a[n];
        for( int i=0; i<n; i++){
        scanf("%d", &a[i]);
        }


    printf("Entered array is : \n");
        int j=1;
        for(int i=0; i<n; i++) {
            printf("%d. %d ", j, a[i]);
            printf("\n");
            j++;
        }
        j=1;

    printf("What do you want to do?[1.Insert, 2. Delete]\n");
    scanf("%d", &input);
    switch(input)
    {
    case 1:
        printf("Enter the element to be inserted :\n");
        scanf("%d", &value);
        printf("Where do you want to Insert?\n");
        scanf("%d", &loc);
        n++;
        for (int i = n - 1; i >= loc; i--)
            a[i] = a[i - 1];
        
        a[loc - 1] = value;

        j= 1;
        for(int i=0; i<n; i++) {
            printf("%d. %d ", j, a[i]);
            printf("\n");
            j++;
        }
        break;
    case 2:
        printf("Which element do you want to Delete?[Enter location] \n");
        scanf("%d", &loc);
        for(int i = loc; i<n; i++){
            a[i-1]=a[i];
        }
        if(loc<=n){
            n--;
        }
        printf("Elements after Deletion: \n");
        j= 1;
        for(int i=0; i<n; i++) {
            printf("%d. %d ", j, a[i]);
            printf("\n");
            j++;
        }
        break;
    default:
        printf("\nInvalid Input!\n");
        break;
    }
printf("Do you wish to continue?\n1[yes]/2[no]");
scanf("%d", &k);
if (k==1){
    goto helo;
}
return 0;
}