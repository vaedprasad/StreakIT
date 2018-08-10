//
//  SelectIconCollectionViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 8/6/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit

private let reuseIdentifier = "IconCell"

//proto

class SelectIconCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var challengeName: String?
    var selectedIcon: Icon?
    var isFiltering: Bool = false
    var filteredIcons: [Icon] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Constants.Segue.backToNewChallengeDetail:
            print("icon item tapped, back to new challenge detail")
            let destination = segue.destination as! NewChallengeDetailViewController
            destination.challengeName = challengeName
            destination.selectedIcon = selectedIcon
            
        default:
            print("unexpected segue identifier")
        }
    }
    

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if isFiltering {
            return filteredIcons.count
        } else {
            return Constants.Icons.newChallengeIcons.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IconCollectionViewCell
    
        if isFiltering {
            cell.iconImageView.image = filteredIcons[indexPath.row].getIcon()
            cell.iconLabel.text = filteredIcons[indexPath.row].iconName
        } else {
            cell.iconImageView.image = Constants.Icons.newChallengeIcons[indexPath.row].getIcon()
            cell.iconLabel.text = Constants.Icons.newChallengeIcons[indexPath.row].iconName
        }
        //cell.layer.cornerRadius = 8
        //cell.layer.borderColor = UIColor.stkHotPink.cgColor
        //cell.layer.borderWidth = 0.5
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at \(indexPath.row)")
        if isFiltering {
            selectedIcon = filteredIcons[indexPath.row]
        } else {
            selectedIcon = Constants.Icons.newChallengeIcons[indexPath.row]
        }
        self.performSegue(withIdentifier: Constants.Segue.backToNewChallengeDetail, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }

    func filter(searchTerm: String) {
        if searchTerm.isEmpty {
            isFiltering = false
            filteredIcons.removeAll()
        } else {
            isFiltering = true
            filteredIcons = Constants.Icons.newChallengeIcons.filter({
                return $0.iconName.localizedCaseInsensitiveContains(searchTerm)
            })
        }
    }
    
    func icon(at indexPath: IndexPath) -> Icon {
        if isFiltering {
            return filteredIcons[indexPath.item]
        } else {
            return Constants.Icons.newChallengeIcons[indexPath.item]
        }
    }
}

extension SelectIconCollectionViewController: UISearchBarDelegate  {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
        
        /*
         if(searchText.isEmpty){
         isFiltering = false
         } else {
         filter(searchTerm: searchText)
         }
         self.collectionView?.reloadData()*/
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        filter(searchTerm: "")
        self.collectionView?.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(searchTerm: searchText)
        //let indices: IndexSet = [1]
        //self.collectionView?.reloadData()
        //self.collectionView?.reloadSections(indices)
        //searchBar.becomeFirstResponder()
    }
    
}
