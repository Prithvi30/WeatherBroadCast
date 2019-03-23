//
//  ViewController.swift
//  DemoApp
//
//  Created by Prithvi Raj on 11/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var fbbutton: UIButton!
    
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.isHidden = true
        
        fbbutton.layer.cornerRadius = 5
//        let loginButton = FBSDKLoginButton()
//        //loginButton.center = view.center
//
//        loginButton.frame = CGRect(x: 100, y: self.view.center.y, width: 200, height: 50)
//
//        view.addSubview(loginButton)
        
        //creating button
     //   let loginButton = LoginButton(readPermissions: [ .publicProfile ])
       // loginButton.center = view.center
        
        //fbbutton.delegate = self

        //adding it to view
        //view.addSubview(loginButton)
        
        if FBSDKAccessToken.current() != nil{
           // fetchUserProfile()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "VC") as? SecondVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
    }
    @IBAction func LoginwithFBTapped(_ sender: UIButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.fetchUserProfile()
                }
            }
        }    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         if(FBSDKAccessToken.current() != nil) {
            fetchUserProfile()
        }
    }
    
    
    @objc func loginButtonClicked() {
       
    }
    
    //function is fetching the user data
    /* func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as? [String : AnyObject]
                    print(result!)
                   // print(self.dict)
                    
                    
                    //parse the fields out of the result
                    if
                        let fields = result as? [String:Any],
                        let firstName = fields["first_name"] as? String,
                        let lastName = fields["last_name"] as? String
                    {
                        print("firstName -> \(firstName)")
                        print("lastName -> \(lastName)")
                    }
                
                    
                    
                    
                }
            })
        }
    } */
    func fetchUserProfile() {
        // Create request for user's Facebook data
        let request = FBSDKGraphRequest(graphPath:"me", parameters:["fields": "id,name,first_name,last_name,email"])
        
        // Send request to Facebook
        request!.start {
            
            (connection, result, error) in
            
            if error != nil {
                // Some error checking here
            }
            else if let userData = result as? [String:AnyObject] {
                
                // Access user data
                let username = userData["name"] as? String
                print(username!)
                
                let email = userData["email"] as? String
                print(email!)
                
                let id = userData["id"] as? String
                print(id!)
                
                let url = "https://graph.facebook.com/\(id!)/picture?type=large&return_ssl_resources=1"
                print(url)
                
                
                
                UserDefaults.standard.set(username, forKey: "name")
                
                UserDefaults.standard.set(email, forKey: "email")
                
                UserDefaults.standard.set(url, forKey: "url")

                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "VC") as? SecondVC
//
//                vc?.user  = username!
//                vc?.emails = email!
               vc?.id = url
//
//
//
//
               self.present(vc!, animated: true, completion: nil)
                
            }
        }
    }
   
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        fetchUserProfile()
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
      //  print("Log out Tapped")
    }
}
