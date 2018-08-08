//
//  NewChallengeDetailViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/31/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

class NewChallengeDetailViewController: UIViewController {

    @IBOutlet weak var newChallengeTitleTextField: UITextField!
    //@IBOutlet weak var newChallengeDescriptionTextView: UITextView!
    @IBOutlet weak var newChallengeIconButton: UIButton!
    
    var challenge: Challenge!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateWithChallenge() {
        newChallengeTitleTextField.text = challenge.name
        newChallengeIconButton.imageView?.image = challenge.getIcon()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Constants.Segue.saveNewChallenge:
            print("save bar button item tapped")
            guard let challengeName = newChallengeTitleTextField.text else { return }
            //guard let challengeDescription = newChallengeDescriptionTextView.text else { return }
            ChallengeService.createChallenge(name: challengeName, icon: "pushups")
            
        //case "cancel":
        //    print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
