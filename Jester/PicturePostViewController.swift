//
//  PicturePostViewController.swift
//  Jester
//
//  Created by Charles Fayal on 7/5/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Parse

class PicturePostViewController: ParseViewController {
    
    var tapGesture:UITapGestureRecognizer!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    //Mark Gestures
    @IBAction func screenTapped(sender: UITapGestureRecognizer)
    {
        print("screen tapped")
        self.view.endEditing(true)
    }
    //MARK Buttons
    @IBAction func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)
    }
    @IBAction func postButton(sender: AnyObject) {
        let newPost = ContentProfile(type: .picture)
        newPost.contentImage = postImage.image!
        //newPost.creator = currentUser ***
        newPost.caption = captionText.text
        newPost.creator = PFUser.currentUser()?.valueForKey("name")! as! String
        createPost()
    }
    //MARK Adding caption 
    /**
     Dismisses the keyboard on return
    */
    
    func createPost() {
        if captionText.text == "" {
            displayAlert("No description", message: "Please add a description")
        } else {
           self.startActivityIndicator()
            let newContentProfile = ContentProfile(type: .picture)
            newContentProfile.caption = captionText.text
            newContentProfile.creator = PFUser.currentUser()?.valueForKey("name") as! String
            newContentProfile.contentImage = postImage.image
        
            contentManager.newPost(newContentProfile, sender: self)
        }
    }
    //MARK Activity Indicator 
    /**
     Stops user interaction and puts a activity indicator on the screen
    */

    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedImage  != nil {
            postImage!.image = selectedImage
        } else { print("selected image is nil")}
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.screenTapped(_:)))
        self.view.addGestureRecognizer(tapGesture)
   
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
