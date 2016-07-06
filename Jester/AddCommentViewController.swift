//
//  AddCommentViewController.swift
//  Jester
//
//  Created by Charles Fayal on 7/5/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var captionText: UITextView!
    
    @IBAction func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)
    }
    @IBAction func postButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)
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
