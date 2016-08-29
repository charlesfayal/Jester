//
//  ContentProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 6/30/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Foundation


/**
 This is the parent class to all the swipe screens. This class creates the swipe box, its buttons, adds username, likes for the post etc..
 Children profile add all of the content that should go in the contentView
 */
@IBDesignable class SwipeView: UIView{
    
    //view that is used to put the profile in
    var view:UIView!
    var contentProfile:ContentProfile!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var username: UILabel!

    @IBAction func commentAction(sender: AnyObject) {
        
    }
    
    @IBAction func shareAction(sender: AnyObject) {
    }
    @IBAction func likeAction(sender: AnyObject) {
        if self.liked { //unliking
            likeButton.setImage(UIImage(named:"unlikedStar"),forState: .Normal)
            viewDisliked()
        } else { //liking
            likeButton.setImage(UIImage(named:"likedStar") , forState: .Normal)
            viewLiked()
        }
    }
    
    //Necessary variables
    var creator:String!
    var liked:Bool = false
    var objectId: String!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("error with initializing SwipeView")
       // Setup()
    }
    override init(frame: CGRect){
        super.init(frame:frame)
        print("init with frame only")
   //     Setup()
    }
    init(frame: CGRect, contentProfile: ContentProfile){
        super.init(frame: frame)
        self.contentProfile = contentProfile
    }

    //must be done after the view is created
    func Setup() {
        //Create the swipe view border and rounded corners
        self.autoresizesSubviews = false
        view.backgroundColor = UIColor(red: 239, green: 239, blue: 244, alpha: 0.4)
   

        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGrayColor().CGColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true //clips anything that would go past rounded edges
        self.userInteractionEnabled = true
    }
     func update(){
        username.text = contentProfile.creator
        likesLabel.text = "\(contentProfile.likes.count)"
        liked = contentProfile.liked
        
    }
    
    func viewLiked(){
        self.liked = true
        contentManager.profileLiked(self.contentProfile)
    }
    func viewDisliked(){
        self.liked = false
        contentManager.profileDisliked(self.contentProfile)
    }
    
    //background color
    
    
    
    

}
