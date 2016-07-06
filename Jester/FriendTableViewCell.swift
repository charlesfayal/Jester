//
//  FriendTableViewCell.swift
//  Jester
//
//  Created by Charles Fayal on 7/5/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsNameLabel: UILabel!
    
    
    @IBOutlet weak var selectedBox: UIButton!
    var friendSelected = false
    @IBAction func selectButton(sender: AnyObject) {
        //Change button image from selected to unselected and vice versa
        if friendSelected {
            friendSelected = false
            if let image = UIImage(named: "unselected box"){
                selectedBox.setImage(image, forState: .Normal)
            } else {
                print("didnt exist")
            }
        } else {
            friendSelected = true
            if let image = UIImage(named: "selected box"){
                selectedBox.setImage(image, forState: .Normal)
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
