//
//  SettingsViewController.swift
//  Jester
//
//  Created by Charles Fayal on 8/10/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func removePosts(sender: AnyObject) {
        contentManager.removeUsersPosts()
        
    }
    @IBAction func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToProfile", sender: self)
    }
    @IBAction func logOut(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToLogin", sender: self)
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
