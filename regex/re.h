#include <string>
#include <iostream>
using namespace std;

#ifndef RE_H
#define RE_H

class re {
	public:
		RE();
		void add(string);
		void star(string);
		void dot(string);
		void evil(string);
		void add(string, RE);
		bool match(string, RE);

	
