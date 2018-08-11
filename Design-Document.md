# StreakIt

StreakIt is an iOS mobile application that enables users to better their lifestyles by motivating them to complete daily lifestyle streaks for positive habits and share them with their friends.

## Audience

This app is targeted for anyone who is looking to either achieve a goal and develop a better lifestyle.

## Experience

After logging in a user opens StreakIt and is presented with a list of their current challenges, which displays an icon, streak name, current streak, and best streak. Each day, the user has the ability to complete a streak or fail a streak. Users can tap on a streak in the list to open a detail view of the challenge.

# Technical

## Models

Firebase:

* Users
	* UID (String)
		* "name" (String)
		* "email" (String)
		* "username" (String)
		* "profileURL" (String)

* Challenges
	* UID (String)
		* Challenge ID (String)
			* "name" (String)
			* "description" (String)
			* "current_streak" (Int)
			* "max_streak" (Int)
			* "icon" (String)
			* "creator"
				* "uid" (String)
				* "username" (String)

StreakIt will save users basic profile information (name, username, password, email) and their challenge progress (streak start, streak end, current streak, max streak). ADDITIONAL FEATURE: StreakIt will store list of friends and display their streaks in comparison to yours.

## Views

`ListChallengeTableViewCell.swift`
* challengeImageView: UIImageView
* challengeTitleLabel: Label
* challengeSubtitleLabel: Label

`ListNewChallengeTableViewCell.swift`
* newChallengeIconImageView: UIImageView
* newChallengeTitleLabel: Label

`ChallengeDetailViewController.swift`
* challengeTitleLabel: UILabel
* challengeIconImageView: UIImageView
* challengeDescriptionTextView: UITextView
* maxStreakImageView: UIImageView
* maxStreakLabel: UILabel
* currentStreakImageView: UIImageView
* currentStreakLabel: UILabel

`NewChallengeDetailViewController.swift`
* newChallengeTitleTextField: UITextField
* newChallengeImageIcon: UIImageView
* newChallengeDescriptionTextView: UITextView


## Controllers / Routes

Login/Create-Username View Controllers
* `LoginViewController.swift`
	*  User can login using Firebase Authentication
* `HomeTableViewController.swift`
	* User can view all their active challenges
* `ChallengeDetailViewController.swift`
	* When challenge is tapped open detail view of challenge including description
* `ListNewChallengesTableViewController.swift`
	* Presents user with list of default presets for challenges as well as the ability to create their own challenge
* `NewChallengeDetailViewController.swift`
	* Opens detail view for preset challenge or custom challenge where user can insert name, description, and icon
* `CompleteChallengesViewController.swift`
	* Use KolodaView to complete challenges with a Tinder-esque card swiping UX
* `UserProfileViewController.swift`
	* Display user profile including profile image, name, username, etc.
* `SelectIconCollectionViewController.swift`
	* Display collection of icons for user to select
	
## Other

Pending available time I will implement a social aspect to StreakIt where users can add friends and can compete with each other on streaks
