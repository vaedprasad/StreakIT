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
    //@IBOutlet weak var newChallengeIconButton: UIButton!
    @IBOutlet weak var newChallengeIconImageView: UIImageView!
    

    //let tapRec = UITapGestureRecognizer()
    
    var challenge: Challenge! 
    
    var selectedIcon: Icon?
    var challengeName: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        // add it to the image view;
        newChallengeIconImageView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        newChallengeIconImageView.isUserInteractionEnabled = true
        
        //updateWithChallenge()

        
        
        //tapRec.addTarget(self, action: Selector(("tappedImageView")))
        //newChallengeIconImageView.addGestureRecognizer(tapRec)
        //newChallengeIconImageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        //if let imageView = gesture.view as? UIImageView {
            print("Image Tapped")
            //Here you can initiate your new ViewController
            self.performSegue(withIdentifier: Constants.Segue.toIconSelector, sender: nil)
        //}
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateWithChallenge()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateWithChallenge() {
        if let writtenName = challengeName {
            newChallengeTitleTextField.text = writtenName
        } else {
            newChallengeTitleTextField.text = challenge.name
        }
        
        if let icon = selectedIcon {
            //newChallengeIconButton.imageView?.image = icon.getIcon()
            newChallengeIconImageView.image = icon.getIcon()
        } else {
            //newChallengeIconButton.imageView?.image = challenge.getIcon()
            newChallengeIconImageView.image = challenge.getIcon()

        }
        //newChallengeIconButton.imageView?.contentMode = .scaleAspectFit

        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Constants.Segue.saveNewChallenge:
            print("save bar button item tapped")
            guard let challengeName = newChallengeTitleTextField.text else { return }
            if let manuallySelectedIcon = selectedIcon {
                ChallengeService.createChallenge(name: challengeName, icon: manuallySelectedIcon.iconImageIdentifier)
            } else {
                ChallengeService.createChallenge(name: challengeName, icon: challenge.icon)

            }
            //guard let challengeDescription = newChallengeDescriptionTextView.text else { return }
        
        case Constants.Segue.toIconSelector:
            print("icon selector button item tapped")
            guard let challengeName = newChallengeTitleTextField.text else { return }
            let destination = segue.destination as! SelectIconCollectionViewController
            destination.challengeName = challengeName
            //guard let challengeDescription = newChallengeDescriptionTextView.text else { return }
            //ChallengeService.createChallenge(name: challengeName, icon: "pushups")
        //case "cancel":
        //    print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
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
