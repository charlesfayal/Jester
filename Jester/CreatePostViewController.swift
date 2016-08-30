//
//  CreatePostViewController.swift
//  Jester
//
//  Created by Charles Fayal on 8/10/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class CreatePostViewController: ParseViewController, UITextFieldDelegate{
    var newContentProfile:ContentProfile!
    
    //MARK: - Button Actions
    @IBAction override func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier(
            "unwindToMainScreen", sender: self)
    }
    @IBAction func postButton(sender: AnyObject) {
        let success = createPost()
        if success {
            self.performSegueWithIdentifier("addCategoriesSegue", sender: self)
        } else {
            print("unsuccessful creating post")
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
    
    func createPost()-> Bool{
            print("sub class must implement the createPost profile")
            return false
        
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let segueIdentifier = segue.identifier
        //print(segueIdentifier)
        if segueIdentifier == "addCategoriesSegue" {
            print("Segueing to add categories VC")
            let destinationVC = segue.destinationViewController as! AddCategoriesViewController
        destinationVC.newContentProfile = self.newContentProfile
        }
    }
}
