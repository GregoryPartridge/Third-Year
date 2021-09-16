#include<xmmintrin.h>
#include <omp.h> 
#include <stdlib.h>
#include <math.h>
#include <float.h>
#include "mytour.h"


/*
    I was working with my team witch included Thomas Keyes, Imosei Idogho and myself, Gregory Partridge.

    The first thing we implemented was for the functions called in my_tour within mytour.c is that we made static inline.
    It makes the function faster by both eliminating the function-call overhead and permit simplifications at compile time.

    Within the third for loop of the program, we made the ncities - 1 into newncities and brought it outisde the nested for loop.
    By doing so it was only calculated once instead of (n^2 - n) times which in turn reduced the run time of the program.

    We also made a variable with teh calculated distance between the 2 points as it was being calculated twice in the original code.
    By doing so we reduced to only being done once which was important as the new_dist() function was where a large part of the program run time is.

    Another step in our development was trying to intruduce pragma to the program.
    Sadly we only saw the program speed reach the non pragma variant at 5 000+ cities and only saw noteable changes at 100 000 cities.
    When applied on the nested for loops we periodically obtained the wrong answer so we decided to not pursue it.
    Though at one point we had an if else statement for the nested loop much like our first for loop.

    After doing that I added two extra clauses on the if(!visited[j]) line.
    These were to check wether the distance between the x values or y values was greater than the CloseDist value.
    This is because if so then it would be impossible to  be closer than the previuslly closest distance.
    This is beacuse if we had sqrt(x^2 + y^2) > CloseDist where lets say x = 0, them sqrt(y^2) > CloseDist is equal to y > CloseDist.
    This means if one of the x or y values is greater than the CloseDist it is further away than CloseDist from the current city.
    By adding this we drastically cut down the amount of times we have to call the new_dist() function hence greatly improving the run time of the program.
    The reason the distances are squared is to do with our next step.

    The next major time save which was to remove the square root from the distance calculation.
    We originally tried to rewrite the square root function but it was the same speed or slower but I realised that sqrt() is not actually needed.
    This is as if x < y then x^2 < y^2. This shows thatif the CloseDist values are all squared the smallest value will still be the smallest value even when squared.
    This is the reason we square the distances before in the if(!visited[j]) line. T
    The reason we squared the distance instead of getting the square root of the CloseDist is because squareing is much speedier for the computer.
    Because the actual CloseDist is never actually used in the final answer, just the path taken by the trader, we never actually calculated the CloseDist.
    Even though we didn't we could do so if it is ever neccasary simpilly by squaring the CloseDist around lines 99 - 102.
*/

static inline float new_sqr(float x) {
  return x*x;
}

static inline float new_dist(const point cities[], int i, int j) 
{
  return (new_sqr(cities[i].x - cities[j].x)+new_sqr(cities[i].y - cities[j].y));
}

void my_tour(const point cities[], int tour[], int ncities) {
	
	int i,j;
	char *visited = alloca(ncities);
	int ThisPt, ClosePt = 0;
	float CloseDist;
	int endtour = 0;
  
	if (ncities > 5000) {
		
		#pragma omp parallel for
		for (i = 0; i < ncities; i++)
			visited[i] = 0;
			
	} else {
		for (i = 0; i < ncities; i++)
			visited[i] = 0;
	}
		
	ThisPt = ncities-1;
	visited[ncities-1] = 1;
	tour[endtour++] = ncities-1;
	
	float possibleCloseDist;
	int newncities = ncities-1;
	
  for (i = 1; i < ncities; i++) 
  {
		
	  CloseDist = DBL_MAX;
	
	  for (j = 0; j < newncities; j++) 
    {
			
		  if (!visited[j] && new_sqr(cities[ThisPt].x - cities[j].x) < CloseDist && new_sqr(cities[ThisPt].y - cities[j].y) < CloseDist) 
      {
        
			    possibleCloseDist = new_dist(cities, ThisPt, j);
				
			    if (possibleCloseDist < CloseDist) 
          {
				    CloseDist = possibleCloseDist;
				    ClosePt = j;
          }
		  }
	  }
		
	  tour[endtour++] = ClosePt;
	  visited[ClosePt] = 1;
	  ThisPt = ClosePt;
	
	 }
	
}
