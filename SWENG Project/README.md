This repo contains both Accessing Repository REST API and Software Engineering Metric Visualisation Project, though the supporting files and this report will be focusing on the later.
The language I worked in was python. 

# GithubAccess

The requirements for this stage were:

"Interrogate the GitHub API to retrieve and display data regarding the logged in developer."

which I have completed. I gathered my own data by importing the requests library, obtaining the data from the api users’ repositories, and then converted it to a string which I would then print. I would also have functions that would filter the file and obtain relevant data.

# Software Engineering Metric Visualisation Project

I used PyGithub as well as Matplotlib for my graphs for this portion of the project.

My project was to show how connected languages are to other languages and judging from the inputted users’ main languages which was judged by how much they worked with a given language, determine which languages would branch out to the most languages or which languages to use if you wish to branch out to the language of interest.

I initially started by gathering all the languages of the inputted users. I ordered them by how much they used them in projects both for the total sum data as well as the individual user data. From here I decided to aim my project around how connected languages are. I went about this by making a table of height and width the number of languages used.
From here I would go through each language the user used and incremented the relevant languages corresponding to that data.

For the main language connected data, I found the most common language connected to each language and would then add those languages that were the main language to a list with the number of times they were the main language to another language. I would then graph the data.

I used Matplotlib for the visualisations part of the task making 3 graphs in total. 
    -The first showing each language and how much it was used.
    -The second showing how connected each language was to other languages.
    -The third showing how many languages each language represented as the main language connected.
  
*To run the program, you will have to manually edit the file "Users" and add the users you wish to run in the program. I failed to add a method to add users through the program

When you run the program, you will be also given data. The data will be:

    - The languages each language is connected to and how many times.
    - The main language connected to it and how much. Different from the third graph as it is from the language connected to the main rather than the main language.

Note- I know my project was not updated early on, this was due to being in the country over Christmas and having an unreliable internet connection.
