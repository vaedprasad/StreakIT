//
//  HomeViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/24/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    //var challenges = [Challenge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        UserService.posts(for: User.current) { (posts) in
            self.challenges = challenges
            self.tableView.reloadData()
        }*/
        // Do any additional setup after loading the view.
    }
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        //return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeCell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
}
