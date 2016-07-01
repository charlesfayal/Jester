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
    @IBAction func selectButton(sender: AnyObject) {
        print("selected!")
        selectOutlet.imageView!.image = UIImage(named: "selected box") // Not working
    }

}
