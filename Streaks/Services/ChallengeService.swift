//
//  ChallengeService.swift
//  Streaks
//
//  Created by Vaed Prasad on 8/1/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//


import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase
import FirebaseStorage


struct ChallengeService {

    static func createChallenge(name: String, icon: String) {
        let currentUser = CurrentUser.current
        let challenge = Challenge(name: name, icon: icon, creator: currentUser)
        
        let rootRef = Database.database().reference()
        let newChallengeRef = rootRef.child("challenges").child(currentUser.uid).childByAutoId()
        let newChallengeKey = newChallengeRef.key
            
        let challengeDict = challenge.dictValue
        newChallengeRef.updateChildValues(challengeDict)
    }

    static func getChallenges(for user: CurrentUser, completion: @escaping ([Challenge]) -> Void) {
        let ref = Database.database().reference().child("challenges").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let challenges: [Challenge] = snapshot.reversed().compactMap {
                return Challenge(snapshot: $0)
            }
            completion(challenges)
        })
        
        
    }
    
    static func deleteChallenge(challenge: Challenge, completion: @escaping (Bool) -> ()) {
        let currentUser = CurrentUser.current
        let rootRef = Database.database().reference()
        let newChallengeRef = rootRef.child("challenges").child(currentUser.uid).child(challenge.key!)
        newChallengeRef.removeValue { (error, newChallengeRef) in
            if let _ = error  {
                        completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    static func updateChallenge(challenge: Challenge, completion: @escaping (Challenge?) -> ()) {
        let currentUser = CurrentUser.current
        let rootRef = Database.database().reference()
        let newChallengeRef = rootRef.child("challenges").child(currentUser.uid).child(challenge.key!)
        newChallengeRef.updateChildValues(challenge.dictValue) { (error, newChallengeRef) in
            guard error == nil else {
                completion(nil)
                
                return
            }
            newChallengeRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let updatedChallenge = Challenge(snapshot: snapshot) else {
                    completion(nil)
                    return
                }
                completion(updatedChallenge)
            })
        }
    }

}
