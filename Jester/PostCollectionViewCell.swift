//
//  PostCollectionViewCell.swift
//  Jester
//
//  Created by Charles Fayal on 7/7/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var postImage: UIImageView!
    
    @IBAction func postSelected(sender: AnyObject) {
        print("selected!")
    }
}
