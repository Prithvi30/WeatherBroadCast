//
//  SecondVC.swift
//  DemoApp
//
//  Created by Prithvi Raj on 11/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin

class SecondVC: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailID: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    var user = ""
    var emails = ""
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        print(user)
        
        userName.text = UserDefaults.standard.string(forKey: "name")

        emailID.text = UserDefaults.standard.string(forKey: "email")
        let url = UserDefaults.standard.string(forKey: "url")!
        profileImage.downloaded(from: url)
        
        logoutButton.layer.cornerRadius = 5
        button.layer.cornerRadius = 5
              // let data = try? Data(contentsOf: self.imageURL! as URL)
        
                //    DispatchQueue.main.async {
                //    self.profileImage.image = UIImage(data: data!)
        
//        let imageURL = UserDefaults.standard.object(forKey: "URL")
//        print("Image url = \(String(describing: imageURL))")
//        let img = UIImage(data: (imageURL as! NSData) as Data)
//        profileImage.image = img
        
//        let image = UIImage(data: (imageURL as! NSData) as Data)
//        {
//            // use your image here...
//            profileImage.image =
//        }
//        }
    }
    
    
    @IBAction func FBLogout(_ sender: UIButton) {
        
        FBSDKLoginManager().logOut()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "back") as! ViewController
        self.present(vc, animated: true, completion: nil)
        print("out called")
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
