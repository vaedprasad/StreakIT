//
//  CompleteChallengesViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/24/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: Int = 5


class CompleteChallengesViewController: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!
    //var currentUser: CurrentUser?

    
    fileprivate var dataSource: [UIImage] = {
        //var challenges = ChallengeService.getChallenges(for: CurrentUser.current, completion: { (challenges) in
            //
        //})
        var array: [UIImage] = []
        for index in 0..<numberOfCards {
            //array.append(UIImage(named: "Card_like_\(index + 1)")!)
        }
        
        return array
    }()
    
    var images: [UIImage] = [#imageLiteral(resourceName: "pushups"),#imageLiteral(resourceName: "squats"), #imageLiteral(resourceName: "treadmill")]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        //kolodaView.layer.cornerRadius = 8;
        kolodaView.dataSource = self
        kolodaView.delegate = self
        kolodaView.layer.cornerRadius = 8

        // Do any additional setup after loading the view.
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
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
        print("run out of cards")
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
        //openURL:options:completionHandler:
        print("card selected")
    }
}

extension CompleteChallengesViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return images.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: images[index])
    }

//    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
//    }
}
