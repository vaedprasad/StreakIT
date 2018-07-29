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
    
    var images: [UIImage] = [#imageLiteral(resourceName: "btn_heart_red_solid"),#imageLiteral(resourceName: "btn_heart_black_outline"), #imageLiteral(resourceName: "btn_options_black")]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        kolodaView.dataSource = self
        kolodaView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CompleteChallengesViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
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
        return .fast
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: images[index])
    }

//    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
//    }
}
