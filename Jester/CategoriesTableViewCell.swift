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
            if let image = UIImage(named: "unselectedBox"){
                selectOutlet.setImage(image, forState: .Normal)
            } else {
                print("didnt exist")
            }
        } else {
            categorySelected = true
            if let image = UIImage(named: "selectedBox"){
                selectOutlet.setImage(image, forState: .Normal)
            } else {
                print("didnt exist")
            }
        }
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
