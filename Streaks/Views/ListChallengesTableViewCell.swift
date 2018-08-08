//
//  ListChallengesTableViewCell.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/27/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

class ListChallengesTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeSubtitleLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var challengeStatusImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWithChallenge(challenge: Challenge) {
        challengeTitleLabel.text = challenge.name
        challengeSubtitleLabel.text = getCellSubtitle(maxStreak: challenge.maxStreak, currentStreak: challenge.currentStreak)
        challengeImageView.image = challenge.getIcon()
        
        if Date().hours(to: challenge.cutoffTime) > 24 {
            challengeStatusImageView.image = #imageLiteral(resourceName: "star")
        } else {
            challengeStatusImageView.image = #imageLiteral(resourceName: "sand_glass")
        }
        
        cardView.layer.cornerRadius = 8
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8)
        cardView.layer.shadowPath = shadowPath.cgPath
        cardView.layer.borderColor = UIColor.stkHotPink.cgColor
        cardView.layer.borderWidth = 0.5
        
        //challengeImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        //cardView.backgroundColor = UIColor.stkHotPink
    }
    
    func getCellSubtitle(maxStreak: Int, currentStreak: Int) -> String {
        return "🏆\(maxStreak) 🔥\(currentStreak)"
    }

}
