//
//  CompleteChallengesViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/24/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit
import Koloda

class CompleteChallengesViewController: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!
    //var currentUser: CurrentUser?
    @IBOutlet weak var ChallengeNameLabel: UILabel!
    
    var lastChallengeSelected: Challenge?

    
    
    fileprivate var dataSource: [Challenge] = []
    
    //var images: [UIImage] = [#imageLiteral(resourceName: "pushups"),#imageLiteral(resourceName: "squats"), #imageLiteral(resourceName: "treadmill")]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        kolodaView.dataSource = self
        kolodaView.delegate = self
        kolodaView.layer.cornerRadius = 8
        //kolodaView.layer.borderColor = UIColor.stkHotPink.cgColor
        //kolodaView.layer.borderWidth = 2
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //var uncompletedChallenges: [UIImage] = []
        dataSource = []
        ChallengeService.getChallenges(for: CurrentUser.current, completion: { (challenges) in
            for c in challenges {
                if Date().hours(to: c.cutoffTime) < 24 {
                    self.dataSource.append(c)
                }
            }
            
            DispatchQueue.main.async {
                self.kolodaView.reloadData()
            }
        })
    }

    @IBAction func tappedRefreshButton(_ sender: Any) {
        dataSource = []
        ChallengeService.getChallenges(for: CurrentUser.current, completion: { (challenges) in
            for c in challenges {
                if Date().hours(to: c.cutoffTime) < 24 {
                    self.dataSource.append(c)
                }
            }
            
            DispatchQueue.main.async {
                self.kolodaView.reloadData()
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        kolodaView?.swipe(.left)
    }

    @IBAction func rightButtonTapped(_ sender: UIButton) {
        kolodaView?.swipe(.right)
    }
    
    
}

extension CompleteChallengesViewController: KolodaViewDelegate {
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        ChallengeNameLabel.text = dataSource[index].name
    }

    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
        ChallengeNameLabel.text = "You did it!"
        let alert = UIAlertController(title: "You did it!", message: "You have marked all your challenges for today.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
        //openURL:options:completionHandler:
        print("card selected")
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction.hashValue == 0{
            print("left")
            
            let alert = UIAlertController(title: "Next Steps", message: "Are you sure you did not complete this challenge? This cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.destructive, handler: { action in
                self.dataSource[index].resetStreak()
                ChallengeService.updateChallenge(challenge: self.dataSource[index]) { (updatedChallenge) in
                    //
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)

            
        } else if direction.hashValue == 1 {
            print("right")
            
            dataSource[index].incrementStreak()
            ChallengeService.updateChallenge(challenge: dataSource[index]) { (updatedChallenge) in
                //
            }
            
        }
    }
}

extension CompleteChallengesViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return dataSource.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        //return UIImageView(image: dataSource?[index])
        let imageView = UIImageView(image: dataSource[index].getIcon())
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.stkDarkBlue
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.stkHotPink.cgColor
        imageView.layer.borderWidth = 2
        return imageView

    }
    

//    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
//    }
}
