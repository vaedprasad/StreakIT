//
//  ChallengeDetailViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/30/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

class ChallengeDetailViewController: UIViewController {

    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeIconImageView: UIImageView!
    @IBOutlet weak var challengeDescriptionTextView: UITextView!
    @IBOutlet weak var maxStreakImageView: UIImageView!
    @IBOutlet weak var maxStreakLabel: UILabel!
    @IBOutlet weak var currentStreakImageView: UIImageView!
    @IBOutlet weak var currentStreakLabel: UILabel!
    
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
        challengeTitleLabel.text = challenge.name
        challengeIconImageView.image = challenge.getIcon()
        challengeDescriptionTextView.text = challenge.description
        maxStreakLabel.text = String(challenge.maxStreak)
        currentStreakLabel.text = String(challenge.currentStreak)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /**required init?(coder aDecoder: NSCoder) {
        super.
        fatalError("init(coder:) has not been implemented")
    }*/

}
