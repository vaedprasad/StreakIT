Design Document

#Streaks
Streaks is an iOS mobile application that enables users to better their lifestyles by motivating them to complete daily lifestyle streaks for positive habits and share them with their friends.

##Audience
This app is targeted for anyone who is looking to either achieve a goal and develop a better lifestyle.

##Experience
After logging in a user opens Streaks and is presented with a list of their current challenges, which displays an icon, streak name, current streak, and best streak. Each day, the user has the ability to complete a streak or fail a streak. Users can tap on a streak in the list to open a detail view of the challenge.

#Technical

##Models
Firebase:

* Challenge
	* Current Streak (Int)
	* Max Streak (Int)
	* Icon (String)
	* Challenge Name (String)
	* Challenge Description (String)

* User
	* Name (String)
	* Email (String)
	* Username (String)
	* Password (String)
	* Challenges


Streaks will save users basic profile information (name, username, password, email) and their challenge progress (streak start, streak end, current streak, max streak). ADDITIONAL FEATURE: Streaks will store list of friends and display their streaks in comparison to yours.

##Views

ListChallengeTableViewCell
* Current Streak (Label)
* Max Streak (Label)
* Icon (UIImage)
* Challenge Name (Label)
* Completed Icon (UIImage)

ListNewChallengeTableViewCell
* Current Streak (Label)
* Max Streak (Label)
* Icon (UIImage)
* Challenge Name (Label)
* Add Icon (UIImage)

##Controllers / Routes

Login/Create-Username View Controllers

* 3 Tab View Controller (TabBarViewController.swift)
* Home: View all challenges (ListChallengesViewController.swift)
* Detail: When challenge is tapped open detail view of challenge including description (ChallengeDetailViewController.swift)
* New Challenge: When challenge is tapped

##Other
Pending available time I will implement a social aspect to streaks where users can add friends and can compete with each other on streaks
