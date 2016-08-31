//
//  UserCategoriesViewController.swift
//  Jester
//
//  Created by Charles Fayal on 8/30/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Parse // TODO why is this not handed down from parse view controller
class UserCategoriesViewController:ParseViewController, CategoriesTableViewController , UITableViewDelegate, UITableViewDataSource  {
    var categories = ["Humor", "Sports", "Action", "Stories","Daily Funny"]
    var usersCategories = [String]()
    var currentUser:PFUser!
    @IBOutlet weak var tableView: UITableView!

    @IBAction override func returnButton(sender: AnyObject) {
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
        if usersCategories.contains(category){
            cell.selectButton(self)
        }
        return cell
    }

    func addCategory(category:String){
        print("Adding \(category) to user")
        if usersCategories.contains(category){
        } else {
            currentUser.addObject(category, forKey: "categories")
            currentUser.saveInBackground()
        }
    }
    func removeCategory(category:String){
        print("Removing \(category) to user")
        usersCategories = currentUser.objectForKey("categories") as! [String]
        if usersCategories.contains(category){
            currentUser.removeObject(category, forKey: "categories")
            currentUser.saveInBackground()
        } else {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = PFUser.currentUser()! // should use some checking here
        usersCategories = currentUser.objectForKey("categories") as! [String]

        print("usere categories \(usersCategories)")
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
