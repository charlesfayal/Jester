//
//  AddCategoriesViewController.swift
//  Jester
//
//  Created by Charles Fayal on 8/9/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class AddCategoriesViewController: ParseViewController, CategoriesTableViewController , UITableViewDelegate, UITableViewDataSource {
    var categories = ["Humor", "Sports", "Action", "Stories","Daily Funny"]
    var newContentProfile = ContentProfile()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func postButton(sender: AnyObject) {
        contentManager.newPost(newContentProfile, sender: self)
    }
    @IBAction override func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)
    }
    override func finishedPosting(){
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:AddCategoriesTableViewCell = tableView.dequeueReusableCellWithIdentifier("addCategoriesCell") as! AddCategoriesTableViewCell
        let category = categories[indexPath.row]
        cell.tableViewController = self
        cell.setCellCategory(category)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       let cell =  tableView.cellForRowAtIndexPath(indexPath) as! AddCategoriesTableViewCell
        if cell.categorySelected {
            newContentProfile.addCategory(cell.category)
        } else {
           newContentProfile.removeCategory(cell.category)
        }
    }
    func addCategory(category:String){
        newContentProfile.addCategory(category)
    }
    func removeCategory(category:String){
        newContentProfile.removeCategory(category)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Adding categories view controller loaded")
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
