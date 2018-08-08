//
//  Challenge.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/27/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot


class Challenge {
    var key: String?
    var name: String
    
    var lastCompletionTime: Date
    var nextDayTime: Date
    var cutoffTime: Date
    
    var icon: String
    var currentStreak: Int
    var maxStreak: Int
    var creator: CurrentUser

    var dictValue: [String : Any] {
        //let createdAgo = creationDate.timeIntervalSince1970
        let userDict = ["uid" : creator.uid,
                        "username" : creator.username]
        
        return ["name" : name,
                "last_completion_time" : lastCompletionTime.timeIntervalSince1970,
                "next_day_time" : nextDayTime.timeIntervalSince1970,
                "cutoff_time" : cutoffTime.timeIntervalSince1970,
                "icon" : icon,
                "current_streak" : currentStreak,
                "max_streak" : maxStreak,
                "creator" : userDict]
    }
    
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let name = dict["name"] as? String,
            let lastCompletionTime = dict["last_completion_time"] as? TimeInterval,
            let nextDayTime = dict["next_day_time"] as? TimeInterval,
            let cutoffTime = dict["cutoff_time"] as? TimeInterval,
            let icon = dict["icon"] as? String,
            let currentStreak = dict["current_streak"] as? Int,
            let maxStreak = dict["max_streak"] as? Int,
            let userDict = dict["creator"] as? [String: Any],
            let uid = userDict["uid"] as? String,
            let username = userDict["username"] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.name = name
        self.lastCompletionTime = Date(timeIntervalSince1970: lastCompletionTime)
        self.nextDayTime = Date(timeIntervalSince1970: nextDayTime)
        self.cutoffTime = Date(timeIntervalSince1970: cutoffTime)
        self.icon = icon
        self.currentStreak = currentStreak
        self.maxStreak = maxStreak
        self.creator = CurrentUser(uid: uid, username: username)
    }
    
    //Testing Initializer (ONLY USED FOR HARDCODING CHALLENGES
    init(name: String, lastCompletionTime: Date, icon: String, currentStreak: Int, maxStreak: Int, creator: CurrentUser) {
        self.name = name
        self.lastCompletionTime = lastCompletionTime
        self.nextDayTime = lastCompletionTime.midnightToday
        self.cutoffTime = lastCompletionTime.midnightTonight
        self.icon = icon
        self.currentStreak = currentStreak
        self.maxStreak = maxStreak
        self.creator = creator
    }
    
    init(name: String, icon: String, creator: CurrentUser) {
        self.name = name
        self.lastCompletionTime = Date()
        self.nextDayTime = lastCompletionTime.midnightToday
        self.cutoffTime = lastCompletionTime.midnightTonight
        //var b = lastCompletionTime.cutoffTime
        self.icon = icon
        self.maxStreak = 0
        self.currentStreak = 0
        self.creator = creator
    }
    
    func setFirstTimeWindows() {
        nextDayTime = lastCompletionTime.midnightToday
        cutoffTime = lastCompletionTime.midnightTonight
    }
    
    func setTimeWindows() {
        nextDayTime = lastCompletionTime.midnightTonight
        cutoffTime = lastCompletionTime.midnightTomorrow
    }
    
    func canCompleteChallenge() -> Bool {
        let now = Date()
        return now >= nextDayTime
    }
    
    func isStreakExpired() -> Bool {
        let now = Date()
        return now >= cutoffTime
    }
    
    func hoursUntilCutoff() -> Int {
        let now = Date()
        return now.hours(to: cutoffTime)
    }
    
    func incrementStreak() {
        currentStreak += 1
        compareMaxStreak()
        lastCompletionTime = Date()
        setTimeWindows()
    }
    
    func resetStreak() {
        currentStreak = 0
        lastCompletionTime = Date()
        setFirstTimeWindows()
    }
    
    func compareMaxStreak() {
        if currentStreak > maxStreak {
            maxStreak = currentStreak
        }
    }
    
    func getIcon() -> UIImage {
        guard let image = UIImage(named: "\(icon)") else {
            fatalError("icon image not found for the name: \(icon)")
        }
        return image
    }

    
}

extension Date {

    var midnightToday: Date {
        let cal = Calendar.current
        //cal.timeZone = TimeZone(identifier: "Europe/Paris")!
        return cal.startOfDay(for: self)
    }
    
    var midnightTonight: Date {
        let cal = Calendar.current
        //cal.timeZone = TimeZone(identifier: "Europe/Paris")!
        return cal.date(byAdding: .day, value: 1, to: self.midnightToday)!
    }
    
    var midnightTomorrow: Date {
        let cal = Calendar.current
        //cal.timeZone = TimeZone(identifier: "Europe/Paris")!
        return cal.date(byAdding: .day, value: 1, to: self.midnightTonight)!
    }
    
    func hours(to date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: self, to: date).hour ?? 0
    }
}

//let currentIcon = Icons.pushups
//
//let iamge = currentIcon.image
//
//
//
//enum Icons: Int {
//    case pushups
//    case running
//
//    var image: UIImage {
//        switch self {
//        case .pushups:
//            return UIImage(named: "pushup")
//        default:
//            <#code#>
//        }
//    }
//
//}
