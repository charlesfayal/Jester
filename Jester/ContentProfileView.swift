//
//  ContentProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 6/30/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Foundation
protocol ProfileView {
    func update()
}
/**
 This is the parent class to all the swipe screens. This class creates the swipe box, its buttons, adds username, likes for the post etc..
 Children profile add all of the content that should go in the contentView
 */
class ContentProfileView: UIView, ProfileView {
    var swipeScreen: MainScreenViewController!
    
    var contentProfile:ContentProfile! //Not sure if it should even have this variable
    
    var previousProfile: ContentProfileView!
    var nextProfile: ContentProfileView!
    
    var contentView:UIView!
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var likesLabel: UILabel!
    
    //Necessary variables
    var likes:Int!
    var creator:String!
    var liked:Bool = false
    var objectId: String!
    
    
    //UI space allocaitons
    let titleHeight: CGFloat = 40

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    init(frame: CGRect, contentProfile: ContentProfile, swipeScreen:MainScreenViewController){
        self.swipeScreen = swipeScreen
        self.contentProfile = contentProfile
        
        creator = contentProfile.creator
        likes = contentProfile.likes.count
        liked = contentProfile.liked
        objectId = contentProfile.objectId
    super.init(frame:frame)
        nibSetup()

    }
    func update(){
        creator = contentProfile.creator
        likes = contentProfile.likes.count
        liked = contentProfile.liked
        objectId = contentProfile.objectId
        
        
    }
   private func nibSetup() {
    //if we want to add shadow I need to make a shadow view
    //self.layer.shadowColor = UIColor.purpleColor().CGColor
    //self.layer.shadowRadius = 3
    
    self.backgroundColor = UIColor.whiteColor()
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.lightGrayColor().CGColor
    self.layer.cornerRadius = 10
    self.clipsToBounds = true //clips anything that would go past rounded edges

    
    //title view is where username and share, like etc buttons are
    let titleView = createTitleView()
    self.addSubview(titleView)
    
    let contentViewFrame = CGRect(origin: CGPoint(x: 0,y:0) , size: CGSize(width: self.frame.height, height: self.frame.height - titleView.frame.height))
    contentView = UIView(frame: contentViewFrame)
    self.addSubview(contentView)
    self.userInteractionEnabled = true

    }
    func createTitleView() -> UIView {
        //title frame
        
        let titleFrame =   CGRectMake(0, self.frame.height - titleHeight, self.frame.width , titleHeight)
        let titleView = UIView(frame: titleFrame)
        titleView.layer.borderWidth = 1
        titleView.layer.borderColor = UIColor.lightGrayColor().CGColor
        //Username
        let creatorFrame = CGRectMake(2, 0, self.frame.width / 2 , titleHeight)
        let contentCreator = UILabel(frame: creatorFrame)
        contentCreator.text = self.creator
        contentCreator.textColor = themeColor
        contentCreator.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 18)
        titleView.addSubview(contentCreator)
        
        let buffer:CGFloat = 10
        var xLocation = titleFrame.width - buffer
        //Likes
        let likesLength:CGFloat = 60
        xLocation -= likesLength
        let likesFrame = CGRectMake(xLocation, 0, likesLength, titleHeight)
        let commentLabel = UILabel(frame: likesFrame)
        commentLabel.text = "\(self.likes)"
        commentLabel.textAlignment = NSTextAlignment.Left
        commentLabel.textColor = themeColor
        commentLabel.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 18)
        
        titleView.addSubview(commentLabel)
        
        //buttons
        let imageSize:CGFloat = 20
        //like button
        xLocation -= (buffer + imageSize)
        var likeImage = UIImage()
        if self.liked{
            likeImage = UIImage(named:"likedStar")!
        } else {
            likeImage = UIImage(named:"unlikedStar")!
        }
        let likeFrame = CGRectMake(xLocation , 8 , imageSize, imageSize)
        likeButton = UIButton(frame: likeFrame)
        likeButton.addTarget(self, action: #selector(ContentProfileView.likeButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        likeButton.setImage(likeImage, forState: .Normal)
        titleView.addSubview(likeButton)
        
        //comment button
        xLocation -= (buffer + imageSize)
        let commentImage = UIImage(named:"commentButton")
        let commentFrame = CGRectMake(xLocation , 8 , imageSize, imageSize)
        commentButton = UIButton(frame: commentFrame)
        commentButton.setImage(commentImage, forState: .Normal)
        commentButton.addTarget(self, action: #selector(ContentProfileView.commentButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        titleView.addSubview(commentButton)
        
        //share button
        xLocation -= (buffer + imageSize)
       let shareImage = UIImage(named:"shareButton")
        let shareFrame = CGRectMake(xLocation , 8 , imageSize, imageSize)
        shareButton = UIButton(frame: shareFrame)
        shareButton.setImage(shareImage, forState: .Normal)
        shareButton.addTarget(self, action: #selector(ContentProfileView.shareButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        titleView.addSubview(shareButton)
        
        
        return titleView
    }
     func likeButtonPressed(sender: AnyObject){
        print("like button pressed")
        if (self.liked == true) {
            self.liked = false
            likeButton.setImage(UIImage(named: "unlikedStar"), forState: .Normal)
            contentManager.profileDisliked(self.contentProfile)
        } else {
            self.liked = true
            likeButton.setImage(UIImage(named: "likedStar"), forState: .Normal)
            contentManager.profileLiked(self.contentProfile)
        }
    }
    @IBAction func commentButtonPressed(sender: AnyObject){
        print("comment button pressed")
        swipeScreen.performSegueWithIdentifier("toComments", sender: swipeScreen)
    }
    func shareButtonPressed(){
        print("share button pressed")
        swipeScreen.performSegueWithIdentifier("toShare", sender: swipeScreen)

    }

}
