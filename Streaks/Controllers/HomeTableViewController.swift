//
//  HomeTableViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/26/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var challenges = [Challenge]()
    var lastChallengeSelected: Challenge?
    var currentUser: CurrentUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //self.tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.tableView.separatorColor = UIColor.stkHotPink//UIColor(white: 0.95, alpha: 1)
        navigationItem.title = "Challenges"
        currentUser = CurrentUser.current
        //print(currentUser)
        ChallengeService.getChallenges(for: currentUser!) { (challenges) in
            self.challenges = challenges
            self.tableView.reloadData()
            print(self.challenges.count)
        }
        
        //newChallenges.append(NewChallenges(sectionName: "Custom Challenge", isCustom: true, sectionChallenges: [Challenge(name: "Create Your Own Challenge", description: "Create Your Custom Challenge", icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user)]))
//        challenges = API.getChallenges()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ChallengeService.getChallenges(for: currentUser!) { (challenges) in
            self.challenges = challenges
            self.tableView.reloadData()
            //print(self.challenges.count)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return challenges.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listChallengesTableViewCell", for: indexPath) as! ListChallengesTableViewCell
        //cell.contentView.backgroundColor = UIColor.stkSeafoamGreen//UIColor(white: 0.95, alpha: 1)
        cell.setupWithChallenge(challenge: challenges[indexPath.row])
        //cell.textLabel?.text = "Cell Row: \(indexPath.row) Section: \(indexPath.section)"
        
        return cell
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastChallengeSelected = challenges[indexPath.row]
        self.performSegue(withIdentifier: Constants.Segue.toChallengeDetail, sender: self)
        
        
        
        //let challengeDetailViewController = ChallengeDetailViewController()
        //challengeDetailViewController.updateWithChallenge(challenge: challenges[indexPath.row])
        
        //navigationController?.pushViewController(challengeDetailViewController, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //print("deleted item")
            let alert = UIAlertController(title: "Warning", message: "Are you sure you would like to delete this challenge? This cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { action in
                ChallengeService.deleteChallenge(challenge: self.challenges[indexPath.row]) { (isDeleted) in
                 //any usage for isDeleted (Bool)
                 }
                ChallengeService.getChallenges(for: self.currentUser!) { (challenges) in
                 self.challenges = challenges
                 self.tableView.reloadData()
                 print(self.challenges.count)
                 }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        /**ChallengeService.updateChallenge(challenge: Challenge()) { (updatedChakleng) in
            <#code#>
        }*/
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        //set challenges
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else { return }
        
        // 2
        if identifier == Constants.Segue.toChallengeDetail {
            let destination = segue.destination as! ChallengeDetailViewController
            destination.challenge = self.lastChallengeSelected
            
        }
    }
    


}
