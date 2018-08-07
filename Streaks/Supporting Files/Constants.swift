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
            NewChallenges(sectionName: "Custom Challenge", isCustom: true, sectionChallenges: [Challenge(name: "Custom Challenge", lastCompletionTime: Date(), icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user)]),
            NewChallenges(sectionName: "Preset Challenges", isCustom: false, sectionChallenges: [
                Challenge(name: "No Soda", lastCompletionTime: Date(), icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user),
                Challenge(name: "Skip Dessert", lastCompletionTime: Date(), icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user),
                Challenge(name: "Take a Walk", lastCompletionTime: Date(), icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user),
                Challenge(name: "Exercise 30 Minutes", lastCompletionTime: Date(), icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user),
                Challenge(name: "Meditate", lastCompletionTime: Date(), icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user)
                ])
        ]
    }
}
