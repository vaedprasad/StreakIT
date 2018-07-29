//
//  Challenge.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/27/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import Foundation

class Challenge {
    var name: String
    var description: String
    var icon: String
    var currentStreak: Int
    var maxStreak: Int

    init(name: String, description: String, icon: String, currentStreak: Int, maxStreak: Int) {
        self.name = name
        self.description = description
        self.icon = icon
        self.currentStreak = currentStreak
        self.maxStreak = maxStreak
    }

}
