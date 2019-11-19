# 🎉 Events by Facebook

It was fun working on this project, here are some of the things I kept in mind while building this app. I also wanted to explain some of my decisions in this document.

#### CollectionView over TableView
When I started building this app, I initially wanted to stack conflicting events side-by-side. However later it occurred to me that there is no limit on how many such events can conflict with each other. If there are more than 2 such events, then the width will be too small to display enough information.
I am thinking of increasing the cell height for events which are longer, to provide more context for the user.

#### Conflicts Detecting Algorithm
I am sorting the events list before I try to find collisions. The sorting algorithm takes O(n log n). I decided to use ‘.sorted{ }’ to sort them instead of writing my own sorting algorithm.
The event conflict finding algorithm runs on O(n). It works on a single pass because the list is already sorted.
Conflicting events are marked in red color.

#### Codable
I have used Codable to convert the JSON data into something my app can consume. I have added checks so that if the conversion fails, the app won’t crash and will show an error view.

#### Design
While trying to build this app, I’ve tried to remain faithful to the UI design of the Facebook app. I’ve tried to use colors which will make it feel like it is a part of the original app. I visited the Events page to come up with inspiration.

#### Colors
I have added the custom colors to the XCAssets to reuse them easily.

#### Loose Strings
I have taken out all the loose strings, colors and numbers and put them in a Constants.swift file for better organization.

#### Swift Lint
I used Swift Lint to keep track of errors. I have taken it off because I am not sure if you have it on your system and whether that might give some error.

#### Git
I have tracked the major changes with git.

#### Things I will add in version 2.0
- Unit tests. I wanted to generate couple of mock sons with valid and invalid data to test the conflict algorithm.
- Ability to show events which conflict side-by-side. I need to figure out a way to make sure that if 3 or more events are colliding, they shouldn’t clump up together on the same row. It can work on an iPad.
- Display activity icons based on the event title. I have few activity icon sets but I need to be able to associate words with the icon. Eg. ‘beer, pub, drinks’ should point to the ‘bar.png’ image. I found an existing project which returns an appropriate emoji for any search string.
- Dark mode.
- Ability to search for events.
- Make it easy to extend by downloading a JSON from the server.
- Possibly use animations to show cells colliding if there is a scheduling conflict. I’m not sure if this is a good idea. 
