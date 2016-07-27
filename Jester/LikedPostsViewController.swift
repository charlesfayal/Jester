//
//  LikedPostsViewController.swift
//  Jester
//
//  Created by Charles Fayal on 6/29/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class LikedPostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var likedPosts = [ContentProfile]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func followButton(sender: AnyObject) {
    }
    @IBAction func returnButton(sender: AnyObject) {
        performSegueWithIdentifier("unwindToMainScreen", sender: self)
    }
  
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedPosts.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:PostsTableViewCell = tableView.dequeueReusableCellWithIdentifier("likedCell") as! PostsTableViewCell
        let cellProfile = likedPosts[indexPath.row]
        cell.postImage.image = cellProfile.contentImage
        cell.postText.text = cellProfile.caption
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
        
        likedPosts = contentManager.updateLikedPosts()
          tableView.tableFooterView = UIView(frame: CGRect.zero)
      
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.contentMode = .ScaleAspectFit
        
        if  let image = UIImage(named: "Liked")
        {
            imageView.image = image
        } else { print("profile image didn't work") }
        self.navigationItem.titleView = imageView
        
        //Replacing the profile title with an image
        
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
