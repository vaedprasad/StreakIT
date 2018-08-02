//
//  UserService.swift
//  Streaks
//
//  Created by Vaed Prasad on 8/1/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    
    static func show(forUID uid: String, completion: @escaping (CurrentUser?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = CurrentUser(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
}
