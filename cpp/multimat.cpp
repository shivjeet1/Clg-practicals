#include<iostream>
using namespace std;
int main(){
	int n;
	cout<<"Enter the Order of Square Matrix: ";
	cin>>n;
	int a[n][n], b[n][n], c[n][n], i, j, k ;
	cout<<endl<<"Input Matrix A: "<<endl;
	for(i=0;i<=(n-1);i++){
		for(j=0;j<=(n-1);j++){
			cin>>a[i][j];
		}
	}
	cout<<endl<<"Input Matrix B: "<<endl;	
	for(i=0;i<=(n-1);i++){
		for(j=0;j<=(n-1);j++){
			cin>>b[i][j];
		}
	}
	
	cout<<endl<<"Multiplication of Matrices"<<endl;
	for(i=0;i<=(n-1);i++){
		for(j=0;j<=(n-1);j++){
			int s=0;
			for(k=0;k<=(n-1);k++){
				s=s+a[i][k]*b[k][j];
				c[i][j]= s;
			}
		}
	}
	for(i=0;i<=(n-1);i++){
		for(j=0;j<=(n-1); j++){
			cout<<c[i][j]<<"  ";
		}
		cout<<endl;
	}
	return 0;
}
