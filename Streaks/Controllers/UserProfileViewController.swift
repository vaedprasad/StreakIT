//
//  UserProfileViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/26/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit
import FirebaseAuth
import LBTAComponents
import FirebaseDatabase
import FirebaseStorage
import JGProgressHUD

class UserProfileViewController: UIViewController {

    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    let profileImageViewHeight: CGFloat = 56
    lazy var profileImageView: CachedImageView = {
        var iv = CachedImageView()
        iv.backgroundColor = UIColor.stkOffWhite
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = profileImageViewHeight / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User's Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "User's Username"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    let uidLabel: UILabel = {
        let label = UILabel()
        label.text = "User's Uid"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "User's Email"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Your Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(handleSignOutButtonTapped))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Fetch User", style: .done, target: self, action: #selector(handleFetchUserButtonTapped))
        setupViews()
        fetchUser()
        
    }
    
    func fetchUser() {
        hud.textLabel.text = "Fetching user..."
        hud.show(in: view, animated: true)
        if Auth.auth().currentUser != nil {
            guard let uid = Auth.auth().currentUser?.uid else { FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String : Any] else { FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
                let user = CurrentUser(uid: uid, dictionary: dictionary)
                //let prof = dictionary["profileURL"]
                self.uidLabel.text = uid
                self.nameLabel.text = user.name
                self.usernameLabel.text = user.username
                self.emailLabel.text = user.email
                
                guard let imageURL = user.profileImageUrl else {
                    return assertionFailure("Image URL Failed or wasn't present")
                }
                self.profileImageView.loadImage(urlString: imageURL)
                //self.profileImageView.loadImage(urlString: )
                
                FBService.dismissHud(self.hud, text: "Success", detailText: "User fetched!", delay: 1)
                
            }, withCancel: { (err) in
                FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user with error: \(err)", delay: 3)
            })
        }
    }
    
    @objc func handleSignOutButtonTapped() {
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            do {
                try Auth.auth().signOut()
                let loginController = LoginViewController()
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let initVC = storyboard.instantiateInitialViewController()
                self.present(initVC!,animated: true)
                //let loginNavigationController = UINavigationController(rootViewController: loginController)
                //self.performSegue(withIdentifier: "ToMain", sender: nil)
                //self.present(loginController, animated: true, completion: nil)
            } catch let err {
                print("Failed to sign out with error", err)
                FBService.showAlert(on: self, style: .alert, title: "Sign Out Error", message: err.localizedDescription)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        FBService.showAlert(on: self, style: .actionSheet, title: nil, message: nil, actions: [signOutAction, cancelAction], completion: nil)
        
        
    }
    
    fileprivate func setupViews() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(uidLabel)
        view.addSubview(emailLabel)
        
        profileImageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: profileImageViewHeight, heightConstant: profileImageViewHeight)
        nameLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        usernameLabel.anchor(nameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 6, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        uidLabel.anchor(usernameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 6, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        emailLabel.anchor(uidLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 6, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
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
