#include <iostream>
#include <string>
using namespace std;

string possMatches[1000];
int numMatches = 0;

/* function definitions */
void plus(string);
void star(string);
void dot(string);
void evil(string);
void add(string, re);
bool match(string, re);

/* struct definition */

int main(int argc, char *argv[]) {

}

/*function definitions */
void plus(string exp) {
	for (int i = 0; i < numMatches; i++) {
		possMatches[i].append(exp);
		for (int j = 1; j <= numMatches; j++) {
			possMatches[numMatches+j].append(exp);
		}
	}
}

void star(string exp) {
	for (int i = 0; i <= numMatches; i++) {
		possMatches[numMatches+1] = possMatches[i].append(exp);
	}
}

void dot(string exp) {
	string alphanum = {a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,
						A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,
						0,1,2,3,4,5,6,7,8,9}
	for (int j = 1; j <= 62; j++) {
		for (int i = 1; i <= numMatches; i++) {
			possMatches[numMatches+i] = possMatches[i].append(alphanum[j]);
		}
	}

	for (int i
}


