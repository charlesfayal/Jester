//
//  CommentsTableViewCell.swift
//  Jester
//
//  Created by Charles Fayal on 6/30/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
