//
//  LoginViewController.swift
//  Streaks
//
//  Created by Vaed Prasad on 7/23/18.
//  Copyright © 2018 Vaed Prasad. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
import FacebookCore
import FacebookLogin
import SwiftyJSON
import FirebaseStorage
import FirebaseDatabase
import LBTAComponents

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var loginSubtitle: UILabel!
    
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
    lazy var signInWithFacebookButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Login with Facebook", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.stkWhite, for: .normal)
        button.backgroundColor = UIColor.stkFacebookButtonColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 7
        
        button.setImage(#imageLiteral(resourceName: "FacebookButton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        
        button.addTarget(self, action: #selector(handleSignInWithFacebookButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignInWithFacebookButtonTapped() {
        hud.textLabel.text = "Logging in with Facebook..."
        hud.show(in: view, animated: true)
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                print("Succesfully logged in into Facebook.")
                self.signIntoFirebase()
            case .failed(let err):
                FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to get Facebook user with error: \(err)", delay: 3)
            case .cancelled:
                FBService.dismissHud(self.hud, text: "Error", detailText: "Canceled getting Facebook user.", delay: 3)
            }
        }
    }
    
    fileprivate func signIntoFirebase() {
        guard let authenticationToken = AccessToken.current?.authenticationToken else { return }
        print("Auth token: \(authenticationToken)")
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signIn(with: credential) { (user, err) in
            if let err = err {
                FBService.dismissHud(self.hud, text: "Sign up error", detailText: err.localizedDescription, delay: 3)
                print("Error: \(err)")
                return
            }
            print("Succesfully authenticated with Firebase.")
            self.fetchFacebookUser { user in
                print(user)
                self.performSegue(withIdentifier: "ToMain", sender: nil)
            }
        }
    }
    
    fileprivate func fetchFacebookUser(completionHandler: @escaping(CurrentUser?)->()) {
        
        let graphRequestConnection = GraphRequestConnection()
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion) //new
        //let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)
        //print("GraphReq:\(graphRequest)")
        graphRequestConnection.add(graphRequest, completion: { (httpResponse, result) in
            switch result {
            case .success(response: let response):
                
                guard let responseDict = response.dictionaryValue else { FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
                
                let json = JSON(responseDict)
                let name = json["name"].string
                let email = json["email"].string
                let username = json["id"].string //new
                guard let profilePictureUrl = json["picture"]["data"]["url"].string else { FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
                
                self.saveUserIntoFirebaseDatabase(name: name!, username: username!, email: email!, profileURL: profilePictureUrl, completionHandler: completionHandler)
                //self.saveUserIntoFirebaseDatabase() //Inserted
                //                URLSession.shared.dataTask(with: url) { (data, response, err) in
                //                    if err != nil {
                //                        guard let err = err else { FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
                //                        FBService.dismissHud(self.hud, text: "Fetch error", detailText: err.localizedDescription, delay: 3)
                //                        return
                //                    }
                //                    guard let data = data else { FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to fetch user.", delay: 3); return }
                //                    self.profileImage = UIImage(data: data)
                //                    self.saveUserIntoFirebaseDatabase()
                //
                //                    }.resume()
                
                break
            case .failed(let err):
                FBService.dismissHud(self.hud, text: "Error", detailText: "Failed to get Facebook user with error: \(err)", delay: 3)
                
                break
            }
        })
        
        graphRequestConnection.start()
    }
    
    fileprivate func saveUserIntoFirebaseDatabase(name:String, username: String, email: String, profileURL: String, completionHandler: @escaping (CurrentUser?)->()) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        
        let dictionaryValues = ["name": name,
                                "email": email,
                                "username": username,
                                "profileURL": profileURL]
        //let values = [uid : dictionaryValues]
        let ref = Database.database().reference().child("users").child(uid)
        ref.setValue(dictionaryValues) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completionHandler(nil)
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let user = CurrentUser(snapshot: snapshot) else { //read data from Firebase and create new user
                    return completionHandler(nil)
                }
                
                CurrentUser.setCurrent(user, writeToUserDefaults: true)
                
                self.hud.dismiss(animated: true)
                self.dismiss(animated: true, completion: nil)
                completionHandler(user)
            })
        }
        print("Successfully saved user info into Firebase database")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        //self.view.backgroundColor = UIColor.stkCyan
        view.addSubview(signInWithFacebookButton)
        signInWithFacebookButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.centerYAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 50)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
}
