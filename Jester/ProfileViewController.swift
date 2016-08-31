//
//  ProfileViewController.swift
//  Jester
//
//  Created by Charles Fayal on 7/5/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tortalLikesLabel: UILabel!
    @IBOutlet weak var totalViewsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func returnButton(sender: AnyObject) {
        //segues back to main screen
    }
    
    @IBAction func settingsButton(sender: AnyObject) {
        //TODO add settings like logout
    }
    
    @IBAction func unwindToProfile(segue: UIStoryboardSegue){
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentManager.usersPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ProfileTableViewCell = tableView.dequeueReusableCellWithIdentifier("profileCell") as! ProfileTableViewCell
        let cellProfile = Array(contentManager.usersPosts.values)[indexPath.row]
        if let image = cellProfile.contentImage {
            cell.postImage.image = image
        } else { print("\(cellProfile.objectId) has no image")}
        cell.caption.text = cellProfile.caption
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat           {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected with row: \(indexPath.row)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Number of users posts \(contentManager.usersPosts.count)")
        usernameLabel.text = PFUser.currentUser()?.valueForKey("name")  as? String
        contentManager.updateUsersPosts()
        
        //Replacing the profile title with an image
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.contentMode = .ScaleAspectFit
        if  let image = UIImage(named: "Profile")
        {
            imageView.image = image
        } else { print("profile image didn't work") }
        self.navigationItem.titleView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
