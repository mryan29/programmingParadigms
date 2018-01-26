/* JAN24 NOTES */


int length(char * msg) {
	int i;
	for (i=0; msg[i] != 0; i++);
	return i;
}

int main() {
	char *msg = "hello";
	int len = length(msg);
	return 0;
}

/* referncing dijkstra paper about for loop in length func
https://homepages.cwi.nl/~storm/teaching/reader/Dijkstra68.pdf

goto: label telling the program to jump to somewhere
djikstras arg: ppl learned assembly w gotos already then learned hi level code and still used a ton of gotos
he complains that gotos are difficult for other programmers to understand and wants to convince people to use
if clause and while loops and all these great new features




*/
