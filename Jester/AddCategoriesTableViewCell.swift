//
//  AddCategoriesTableViewCell.swift
//  Jester
//
//  Created by Charles Fayal on 8/11/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class AddCategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectOutlet: UIButton!
    var addCategoriesViewController:AddCategoriesViewController!
    var category:String = ""
    var categorySelected = false
    @IBAction func selectButton(sender: AnyObject) {
        //Change button image from selected to unselected and vice versa
        if categorySelected {
            categorySelected = false
            addCategoriesViewController.removeCategory(category)
            if let image = UIImage(named: "unselectedBox"){
                selectOutlet.setImage(image, forState: .Normal)
            } else {
                print("didnt exist")
            }
        } else {
            categorySelected = true
            addCategoriesViewController.addCategory(category)
            if let image = UIImage(named: "selectedBox"){
                selectOutlet.setImage(image, forState: .Normal)
            } else {
                print("didnt exist")
            }
        }
        
    }
    func setCellCategory(category : String ){
        self.category = category
        categoryLabel.text = category
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
