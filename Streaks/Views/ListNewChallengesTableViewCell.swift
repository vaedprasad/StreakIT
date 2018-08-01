//
//  ListNewChallengesTableViewCell.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/30/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

class ListNewChallengesTableViewCell: UITableViewCell {

    @IBOutlet weak var newChallengeIconImageView: UIImageView!
    @IBOutlet weak var newChallengeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWithChallenge(challenge: Challenge) {
        newChallengeIconImageView.image = challenge.getIcon()
        newChallengeTitleLabel.text = challenge.name
        
    }

}
