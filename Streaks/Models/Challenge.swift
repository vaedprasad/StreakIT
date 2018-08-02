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
    var description: String
    var icon: String
    var currentStreak: Int
    var maxStreak: Int
    var creator: CurrentUser

    var dictValue: [String : Any] {
        //let createdAgo = creationDate.timeIntervalSince1970
        let userDict = ["uid" : creator.uid,
                        "username" : creator.username]
        
        return ["name" : name,
                "description" : description,
                "icon" : icon,
                "current_streak" : currentStreak,
                "max_streak" : maxStreak,
                "creator" : userDict]
    }
    
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let name = dict["name"] as? String,
            let description = dict["description"] as? String,
            let icon = dict["icon"] as? String,
            let currentStreak = dict["current_streak"] as? Int,
            let maxStreak = dict["max_streak"] as? Int,
            let userDict = dict["creator"] as? [String: Any],
            let uid = userDict["uid"] as? String,
            let username = userDict["username"] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.name = name
        self.description = description
        self.icon = icon
        self.currentStreak = currentStreak
        self.maxStreak = maxStreak
        self.creator = CurrentUser(uid: uid, username: username)
    }
    
    //Testing Initializer
    init(name: String, description: String, icon: String, currentStreak: Int, maxStreak: Int, creator: CurrentUser) {
        self.name = name
        self.description = description
        self.icon = icon
        self.currentStreak = currentStreak
        self.maxStreak = maxStreak
        self.creator = creator
    }
    
    init(name: String, description: String, icon: String, creator: CurrentUser) {
        self.name = name
        self.description = description
        self.icon = icon
        self.maxStreak = 0
        self.currentStreak = 0
        self.creator = creator
    }
    
    func incrementStreak() {
        currentStreak += 1
    }
    
    func resetStreak() {
        currentStreak = 0
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
