//
//  AddCommentViewController.swift
//  Jester
//
//  Created by Charles Fayal on 7/5/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Parse

class AddCommentViewController: UIViewController {
    var activityIndicator: UIActivityIndicatorView!  = UIActivityIndicatorView()

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var captionText: UITextView!
    
    @IBAction func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)
    }
    @IBAction func postButton(sender: AnyObject) {
        let newPost = ContentProfile(type: .picture)
        newPost.contentImage = postImage.image!
        //newPost.creator = currentUser ***
        newPost.caption = captionText.text
        createPost()
    }
    func createPost() {
        if captionText.text == "" {
            displayAlert("No description", message: "Please add a description")
        } else {
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            let post = PFObject(className: "ContentProfile")
            post["caption"] = captionText.text
            post["creatorId"] = PFUser.currentUser()?.objectId
            let imageData = UIImageJPEGRepresentation(postImage.image!, 0.8)
            let imageFile = PFFile(name: "image.jpeg", data: imageData!)
            post["imageFile"] = imageFile
            post.saveInBackgroundWithBlock { (sucess, error) in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    self.displayAlert("Image Posted!", message: "Your image has been successfully posted")
                    self.performSegueWithIdentifier("unwindToMainScreen", sender: self)

                } else {
                    self.displayAlert("Could not post image", message: "Please try again")
                    
                }
                
            }
        }
    }
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            //self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedImage  != nil {
            postImage!.image = selectedImage
        } else { print("selected image is nil")}
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
