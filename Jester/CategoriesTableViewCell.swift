//
//  CategoriesTableViewCell.swift
//  Jester
//
//  Created by Charles Fayal on 6/30/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectOutlet: UIButton!
    
    var categorySelected = false
    @IBAction func selectButton(sender: AnyObject) {
        //Change button image from selected to unselected and vice versa
        if categorySelected {
            categorySelected = false
            if let image = UIImage(named: "unselected box"){
                selectOutlet.setImage(image, forState: .Normal)
            } else {
                print("didnt exist")
            }
        } else {
            categorySelected = true
            if let image = UIImage(named: "selected box"){
                selectOutlet.setImage(image, forState: .Normal)
            } else {
                print("didnt exist")
            }
        }
    
    }

}
