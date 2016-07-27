//
//  CommentsViewController.swift
//  Jester
//
//  Created by Charles Fayal on 6/29/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var comments = ["Dude that was a sweeet photo", " That was like tottally rad", " I cant believe what I am seeing yo"]
    var creators = ["Chf11002", "SteveyJeezy", " RonDog"]
    var times = ["5m", "6m","1h9m"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)
    }
    
    //MARK: Table View Functions 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell:CommentsTableViewCell = tableView.dequeueReusableCellWithIdentifier("commentsCell") as! CommentsTableViewCell
        //print(comment)
        cell.commentLabel.text = comments[indexPath.row]
        cell.creatorLabel.text = creators[indexPath.row]
        cell.timeLabel.text = times[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView(frame: CGRect.zero)

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
