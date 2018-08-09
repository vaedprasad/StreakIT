//
//  Constants.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/31/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        static let toChallengeDetail = "toChallengeDetail"
        static let toNewChallengeDetail = "toNewChallengeDetail"
        static let toCreateChallenge = "toCreateChallenge"
        static let saveChallenge = "saveChallenge"
        static let saveNewChallenge = "saveNewChallenge"
    }
    
    struct UserDefaults {
        static let currentUser = "currentUser"
    }
    
    struct ListNewChallenges {
        struct NewChallenges {
            var sectionName: String
            var isCustom = Bool()
            var sectionChallenges: [Challenge]
        }
        static let user = CurrentUser.current
        static let newChallenges = [
            NewChallenges(sectionName: "Custom Challenge", isCustom: true, sectionChallenges: [Challenge(name: "Custom Challenge", icon: "pencil", creator: user)]),
            NewChallenges(sectionName: "Preset Challenges", isCustom: false, sectionChallenges: [
                Challenge(name: "15 Pushups", icon: "pushups", creator: user),
                Challenge(name: "No Smoking", icon: "no_smoking", creator: user),
                Challenge(name: "No Facebook", icon: "facebook", creator: user),
                Challenge(name: "Walk Dog", icon: "dog", creator: user),
                Challenge(name: "Practice Piano", icon: "piano", creator: user),
                Challenge(name: "No Alcohol", icon: "no_alcohol", creator: user)
                ])
        ]
    }
    struct Icons {
        static let newChallengeIcons = [
            Icon(iconName: "Pushups", iconImageIdentifier: "pushups"),
            Icon(iconName: "Swimming", iconImageIdentifier: "swimming"),
            Icon(iconName: "No Smoking", iconImageIdentifier: "no_smoking"),
            Icon(iconName: "Dog", iconImageIdentifier: "dog"),
            Icon(iconName: "Walking", iconImageIdentifier: "walking")
        ]
    }
    
}
