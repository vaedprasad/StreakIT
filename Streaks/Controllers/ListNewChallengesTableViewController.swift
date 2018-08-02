//
//  ListNewChallengesTableViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/27/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

class ListNewChallengesTableViewController: UITableViewController {

    var lastChallengeSelected: Challenge?
    
    struct NewChallenges {
        var sectionName: String
        var isCustom = Bool()
        var sectionChallenges: [Challenge]
    }
    
    var newChallenges = [NewChallenges]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = CurrentUser.current
        newChallenges = []
        newChallenges.append(NewChallenges(sectionName: "Custom Challenge", isCustom: true, sectionChallenges: [Challenge(name: "Create Your Own Challenge", description: "Create Your Custom Challenge", icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user)]))
        newChallenges.append(NewChallenges(sectionName: "Preset Challenges", isCustom: false, sectionChallenges: [
            Challenge(name: "No Soda", description: "No Soda Description", icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user),
            Challenge(name: "Skip Dessert", description: "Skip Dessert Description", icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user),
            Challenge(name: "Take a Walk", description: "Take a Walk Description", icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user),
            Challenge(name: "Exercise 30 Minutes", description: "Exercise 30 Minutes Description", icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user),
            Challenge(name: "Meditate", description: "Meditate Description", icon: "pushups", currentStreak: 0, maxStreak: 0, creator: user)]))
        
        //newChallenges
//         Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
//
//         Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return newChallenges.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newChallenges[section].sectionChallenges.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return newChallenges[section].sectionName
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newChallenge", for: indexPath) as! ListNewChallengesTableViewCell

        
        cell.setupWithChallenge(challenge: newChallenges[indexPath.section].sectionChallenges[indexPath.row])
        //cell.newChallengeTitleLabel.text = newChallenges[indexPath.section].sectionChallenges[indexPath.row].name

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastChallengeSelected = newChallenges[indexPath.section].sectionChallenges[indexPath.row]
        self.performSegue(withIdentifier: Constants.Segue.toNewChallengeDetail, sender: self)
        
        
        
        //let challengeDetailViewController = ChallengeDetailViewController()
        //challengeDetailViewController.updateWithChallenge(challenge: challenges[indexPath.row])
        
        //navigationController?.pushViewController(challengeDetailViewController, animated: false)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else { return }
        
        // 2
        if identifier == Constants.Segue.toNewChallengeDetail {
            let destination = segue.destination as! NewChallengeDetailViewController
            destination.challenge = self.lastChallengeSelected
            
        }
    }

}
