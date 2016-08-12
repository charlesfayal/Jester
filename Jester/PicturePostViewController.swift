//
//  PicturePostViewController.swift
//  Jester
//
//  Created by Charles Fayal on 7/5/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Parse

class PicturePostViewController: CreatePostViewController {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionText: UITextView!


    //MARK creating the post functions
    override func createPost() -> Bool {
        if captionText.text == "" {
            displayAlert("No description", message: "Please add a description")
            return false
        } else {
           self.startActivityIndicator()
            newContentProfile = ContentProfile(type: .picture)
            newContentProfile.caption = captionText.text
            newContentProfile.creator = PFUser.currentUser()?.valueForKey("name") as! String
            newContentProfile.contentImage = postImage.image
            return true
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedImage  != nil {
            postImage!.image = selectedImage
        } else { print("selected image is nil")}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        

}
