//
//  CategoriesViewController.swift
//  Jester
//
//  Created by Charles Fayal on 6/29/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var categories = ["Humor", "Sports", "Action", "Stories","Daily Funny"]
    @IBAction func returnButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMainScreen", sender: self)
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CategoriesTableViewCell = tableView.dequeueReusableCellWithIdentifier("categoriesCell") as! CategoriesTableViewCell
        cell.categoryLabel.text  = categories[indexPath.row]
        return cell
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
