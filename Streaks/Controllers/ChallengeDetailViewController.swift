//
//  ChallengeDetailViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/30/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

class ChallengeDetailViewController: UIViewController {

    @IBOutlet weak var challengeTitleTextField: UITextField!
    @IBOutlet weak var challengeIconImageView: UIImageView!
    //@IBOutlet weak var challengeDescriptionTextView: UITextView!
    @IBOutlet weak var maxStreakImageView: UIImageView!
    @IBOutlet weak var maxStreakLabel: UILabel!
    @IBOutlet weak var currentStreakImageView: UIImageView!
    @IBOutlet weak var currentStreakLabel: UILabel!
    @IBOutlet weak var timeLeftImageView: UIImageView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    var challenge: Challenge!
    
    /*init(challenge: Challenge) {
        self.challenge = challenge
        
        super.init(nibName: nil, bundle: nil)
    }*/
    
    /**required init?(coder aDecoder: NSCoder, challenge: Challenge) {
        self.challenge = challenge

        super.init(coder: aDecoder)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWithChallenge()

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateWithChallenge() {
        challengeTitleTextField.text = challenge.name
        challengeIconImageView.image = challenge.getIcon()
        challengeIconImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true

        //challengeDescriptionTextView.text = challenge.description
        //print(challenge.description)
        maxStreakLabel.text = String(challenge.maxStreak)
        maxStreakImageView.image = #imageLiteral(resourceName: "trophy")
        currentStreakLabel.text = String(challenge.currentStreak)
        currentStreakImageView.image = #imageLiteral(resourceName: "fire")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Constants.Segue.saveChallenge:
            print("save bar button item tapped")
            guard let challengeName = challengeTitleTextField.text else { return }
            //guard let challengeDescription = challengeDescriptionTextView.text else { return }
            challenge.name = challengeName
            //challenge.description = challengeDescription
            ChallengeService.updateChallenge(challenge: challenge) { (updatedChallenge) in
                //do anything with updated challenge
            }
            //ChallengeService.createChallenge(name: challengeName, description: challengeDescription, icon: "pushups")
            
            //case "cancel":
            //    print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    /**required init?(coder aDecoder: NSCoder) {
        super.
        fatalError("init(coder:) has not been implemented")
    }*/

}
