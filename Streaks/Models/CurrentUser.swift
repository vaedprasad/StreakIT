//
//  CurrentUser.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/26/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

struct CurrentUser: Codable {
    let uid: String
    var name: String?
    let username: String
    var email: String?
    var profileImageUrl: String?
    
    private static var _current: CurrentUser?
    
    static var current: CurrentUser {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        return currentUser
    }
    
    static func setCurrent(_ user: CurrentUser, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        
        _current = user
    }
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.name = dictionary["name"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileURL"] as? String ?? ""
    }
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String, let name = dict["name"] as? String, let email = dict["email"] as? String, let profileImageUrl = dict["profileURL"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        self.name = name
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
    
    
}
