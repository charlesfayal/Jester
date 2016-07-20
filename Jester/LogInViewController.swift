//
//  LogInViewController.swift
//  Jester
//
//  Created by Charles Fayal on 6/29/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class LogInViewController: UIViewController {
    @IBAction func unwindToLogIn(segue : UIStoryboardSegue){
        PFUser.logOut()
    }
    @IBAction func facebookLogIn(sender: AnyObject) {
        //FACEBOOK Login
        let permissions = ["public_profile"]
        print("fb log in")
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: {
            (user: PFUser?, error: NSError?) in
            print("logging in")
            if let error = error {
                print(error)
            } else {
                if let user = user {
                    print("user info")
                    print(user)
                    
                    self.grabUserInfo()
                    
                    self.performSegueWithIdentifier("loggedIn", sender: self)
                    
                }
            }
        })
        self.performSegueWithIdentifier("loggedIn", sender: self)
    }
    func grabUserInfo(){
        // Grab facebook information
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters:  ["fields": "id, name, gender"])
        graphRequest.startWithCompletionHandler( { (connection, result, error) in
            if error != nil {
                print(error)
            } else if let result = result{
                
                //PFUser.currentUser()!["gender"] = result["gender"]!
                PFUser.currentUser()!["name"] = result["name"]!
                
                
                /*
                 let userID = result["id"]! as! String
                 //! print(userID) var userId = userID
                 
                 let facebookProfilePictureURL = "https://graph.facebook.com/" + userID + "/picture?type=large" // gets profile pictures which is public
                 if let fbpicURL = NSURL(string: facebookProfilePictureURL){
                 if let data = NSData(contentsOfURL: fbpicURL){
                 //self.userImage.image = UIImage(data: data)
                 //segmentation fault was being caused because I didn't have .image being assigned to
                 }
                 }
                 */
                PFUser.currentUser()?.saveInBackground()
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        if let username = PFUser.currentUser()?.username{
            self.performSegueWithIdentifier("loggedIn", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
