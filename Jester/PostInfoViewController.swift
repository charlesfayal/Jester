//
//  PostInfoViewController.swift
//  Jester
//
//  Created by Charles Fayal on 6/30/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class PostInfoViewController: UIViewController {
  
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var message: UITextView!
    
    @IBAction func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)
        
    }
    override func viewDidLoad() {
        
    }

}
