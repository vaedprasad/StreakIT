//
//  CurrentUser.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/26/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import Foundation

struct CurrentUser {
    let uid: String
    let name: String
    let username: String
    let email: String
    let profileImageUrl: String
    //var challenges: [Challenge]
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.name = dictionary["name"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileURL"] as? String ?? ""
    }
}
