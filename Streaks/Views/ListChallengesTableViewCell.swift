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
        challengeImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        cardView.backgroundColor = UIColor.stkHotPink
    }
    
    func getCellSubtitle(maxStreak: Int, currentStreak: Int) -> String {
        return "🏆\(maxStreak) 🔥\(currentStreak)"
    }

}
