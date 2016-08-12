//
//  LinkPostViewController.swift
//  Jester
//
//  Created by Charles Fayal on 8/8/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Parse
class LinkPostViewController: CreatePostViewController {
    var linkURL:NSURL!

    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var urlInput: UITextField!
    @IBOutlet weak var webView: UIWebView!

 
    override func viewDidLoad() {
        super.viewDidLoad()
        urlInput.delegate = self
        descriptionText.layer.borderWidth = 1
        descriptionText.layer.borderColor = UIColor.lightGrayColor().CGColor
        descriptionText.layer.cornerRadius = 10

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {// called when 'return' key pressed. return false to ignore.
        print("text field should return \(urlInput.text)")
        textField.resignFirstResponder()
        let urlText = "http://www.\( urlInput.text!)"
        print(urlText)
        linkURL = NSURL(string: urlText)!
        let request = NSURLRequest(URL: linkURL)
        webView.loadRequest(request)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func createPost() -> Bool{
        print("creating post")
        //TODO needs cleaning up and more checking
        var success = true
        if descriptionText.text == "" {
            displayAlert("No description", message: "Please add a description")
            success = false
            return false
        } else {
            self.startActivityIndicator()
            newContentProfile = ContentProfile(type: .link)
            if linkURL == nil {
                let urlText = "http://www.\( urlInput.text!)"
                linkURL = NSURL(string: urlText)!
                newContentProfile.link = linkURL
            }
            newContentProfile.caption = descriptionText.text
            if success {
                newContentProfile.creator = PFUser.currentUser()?.valueForKey("name") as! String
            }
            print("creating a link post - \(newContentProfile.link.absoluteString)")
            //contentManager.newPost(newPost, sender: self)
            return true
        }
    }
    

}
