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
@IBDesignable class SwipeView: ContentView{
    var superView:UIView!

    var swipeScreen: MainScreenViewController!

    var contentProfile:ContentProfile!
    
    var childView:ContentView!
    
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
        if self.liked {
            //unliking
            likeButton.setImage(UIImage(named:"unlikedStar"),forState: .Normal)
            viewDisliked()
        } else {
            //liking
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
    init(frame: CGRect, contentProfile: ContentProfile){
        super.init(frame:frame)
        self.contentProfile = contentProfile
        Setup()
    }
    func Setup() {
        //Create the swipe view border and rounded corners
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true //clips anything that would go past rounded edges

        self.userInteractionEnabled = true
        
        //TODO issue with dragging and view changing due to changing sizes
        superView = loadViewFromNib()
        superView.frame = bounds
        superView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        addSubview(superView)
        //adds the view to the swipe views

         childView = ImageSwipeView(frame: self.contentView.frame, contentProfile: self.contentProfile)
        contentView.addSubview(childView)
        
    }
    override func update(){
        username.text = contentProfile.creator
        likesLabel.text = "\(contentProfile.likes.count)"
        liked = contentProfile.liked
        childView.update()
        
    }
    
    func viewLiked(){
        self.liked = true
        contentManager.profileLiked(self.contentProfile)
    }
    func viewDisliked(){
        self.liked = false
        contentManager.profileDisliked(self.contentProfile)
    }

    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "SwipeView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
}
