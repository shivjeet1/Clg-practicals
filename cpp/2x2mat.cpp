#include<iostream>
using namespace std;
int main(){
	int a[2][2], i,j;
	cout<<endl<<"input valus for double dimension array"<<endl;
	for (i=0;i<=1;i++){
		for(j=0;j<=1;j++){
			cin>>a[i][j];
		}
	}
	cout<<endl<<"Display of Matrix 2x2:"<<endl;
	for(i=0;i<=1;i++){
		for(j=0;j<=1;j++){
		cout<<a[i][j]<<" ";
		}
	cout<<endl;
	}
return 0;
}
