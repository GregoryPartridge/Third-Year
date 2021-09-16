#include <iostream>
#include <conio.h>
#include <chrono>
#include <time.h>

using namespace std;
using namespace chrono;

int NUM_RUNS = 5000;

int calls = 0;
int depth = 0;
int maxDepth = 0;

int overflows = 0;
int underflows = 0;

int windowsInUse = 2;
int nwindows = 0;

void enter() 
{
	calls++;
	depth++;
	if (depth > maxDepth) 
	{
		maxDepth = depth;
	}
	if (windowsInUse == nwindows) 
	{
		overflows++;
	}
	else 
	{
		windowsInUse++;
	}
}

void exit() 
{
	depth--;
	if (windowsInUse == 2) 
	{
		underflows++;
	}
	else 
	{
		windowsInUse--;
	}
}

int compute_pascal_checks(int row, int position)
{
	int r;
	enter();

	if (position == 1)
	{
		r = 1;
	}
	else if (position == row)
	{
		r = 1;
	}
	else
	{
		r = compute_pascal_checks(row - 1, position) + compute_pascal_checks(row - 1, position - 1);
	}

	exit();
	return r;
}

int compute_pascal(int row, int position) 
{
	if (position == 0) 
	{
		return 1;
	}
	else if (position == row) 
	{
		return 1;
	}
	else 
	{
		return compute_pascal(row - 1, position) + compute_pascal(row - 1, position - 1);
	}
}

void run(int _nwindows)
{
	calls = 0;
	depth = 0;
	maxDepth = 0;

	overflows = 0;
	underflows = 0;

	windowsInUse = 2;
	nwindows = 0;

	nwindows = _nwindows;

	compute_pascal_checks(30, 20);
	printf("Number of Register Windows: %d\n  Number of Calls: %d   Maximum Register Window Depth: %d   Overflows: %d   Underflows: %d\n\n\n", nwindows, calls, maxDepth, overflows, underflows);

}


int main(int argc, char* argv[]) {

	run(6);
	run(8);
	run(16);

	volatile int x = 30;
	int i = 0;
	auto start = high_resolution_clock::now();
	while (i < NUM_RUNS)
	{
		compute_pascal(x, 20);
		i++;
	}
	auto end = high_resolution_clock::now();
	long double duration = duration_cast<nanoseconds>(end - start).count();
	cout << "Time taken " << duration << " nanoseconds\n";
	double time = duration / (double)NUM_RUNS;
	cout << "Average " << time << " nanoseconds\n";
	return 0;
}
