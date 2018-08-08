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
    
    @IBAction func streakFailedButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Next Steps", message: "Are you sure you did not complete this challenge? This cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.destructive, handler: { action in
            self.challenge.resetStreak()
            self.updateWithChallenge()
            ChallengeService.updateChallenge(challenge: self.challenge) { (updatedChallenge) in
                //
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func streakCompletedButtonTapped(_ sender: Any) {
        if !challenge.canCompleteChallenge() {
            let alert = UIAlertController(title: "Already Completed", message: "You have already completed this challenge today. Please wait until tomorrow to complete this challenge again.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else {
            challenge.incrementStreak()
            updateWithChallenge()
            ChallengeService.updateChallenge(challenge: challenge) { (updatedChallenge) in
                //
            }
        }
    }
    
    func updateWithChallenge() {
        if challenge.isStreakExpired() {
            challenge.resetStreak()
            let alert = UIAlertController(title: "Streak Reset", message: "You did not complete your streak yesterday so your streak has been reset.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        challengeTitleTextField.text = challenge.name
        challengeIconImageView.image = challenge.getIcon()
        challengeIconImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        maxStreakLabel.text = "\(String(challenge.maxStreak))d"
        maxStreakImageView.image = #imageLiteral(resourceName: "trophy")
        currentStreakLabel.text = "\(String(challenge.currentStreak))d"
        if challenge.maxStreak == challenge.currentStreak {
            currentStreakImageView.image = #imageLiteral(resourceName: "blue_fire")
        } else {
            currentStreakImageView.image = #imageLiteral(resourceName: "fire")
        }
        if Date().hours(to: challenge.cutoffTime) > 24 {
            timeLeftLabel.text = "Done!"
            timeLeftImageView.image = #imageLiteral(resourceName: "star")
        } else {
            timeLeftLabel.text = "\(String(Date().hours(to: challenge.cutoffTime)))h"
            timeLeftImageView.image = #imageLiteral(resourceName: "sand_glass")
        }


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
