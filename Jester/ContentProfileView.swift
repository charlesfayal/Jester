//
//  ContentProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 6/30/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
class ContentProfileView: UIView {
    var swipeScreen: MainScreenViewController!
    var profileType: contentType = .nothing
    var contentProfile:ContentProfile!
    var previousProfile: ContentProfileView!
    var nextProfile: ContentProfileView!
    var contentView: UIView!
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var likesLabel: UILabel!
    
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
    init(frame: CGRect,  contentProfile:ContentProfile, swipeScreen:MainScreenViewController){
        self.swipeScreen = swipeScreen
        profileType = contentProfile.type
        self.contentProfile = contentProfile
    super.init(frame:frame)
        nibSetup()

    }

   private func nibSetup() {
    //if we want to add shadow I need to make a shadow view
    //self.layer.shadowColor = UIColor.purpleColor().CGColor
    //self.layer.shadowRadius = 3
    
    var yLocation:CGFloat = 0
    self.backgroundColor = UIColor.whiteColor()
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.lightGrayColor().CGColor
    self.layer.cornerRadius = 10
    self.clipsToBounds = true //clips anything that would go past rounded edges
    //print("profile sizes \(self.frame.height) \(self.frame.width)")

    
    switch profileType {
    case contentType.picture:
        print("picture profile")
        contentView = picture()
    case contentType.link:
        print("link profile")
        contentView = website()
    default:
        print("no profile type found")
    }
    self.addSubview(contentView)
    yLocation += contentView.frame.height
    
 
    
    if profileType == .picture {
        let messageFrame = CGRectMake(0, yLocation, self.frame.width, self.frame.height - yLocation - titleHeight)
        let contentMessage = UITextView(frame: messageFrame)
        contentMessage.editable = false
        contentMessage.text = contentProfile.caption
        contentMessage.font = UIFont(name: "Verdana" , size: 17)
        contentMessage.textColor = UIColor.darkGrayColor()
        self.addSubview(contentMessage)
        yLocation += contentMessage.frame.height
    }
    
    let titleView = createTitleView()

    
    self.addSubview(titleView)
    yLocation += titleHeight


    self.userInteractionEnabled = true

    }
    func createTitleView() -> UIView {
        //titel frame
        
        let titleFrame =   CGRectMake(0, self.frame.height - titleHeight, self.frame.width , titleHeight)
        let titleView = UIView(frame: titleFrame)
        titleView.layer.borderWidth = 1
        titleView.layer.borderColor = UIColor.lightGrayColor().CGColor
        //Username
        let creatorFrame = CGRectMake(2, 0, self.frame.width / 2 , titleHeight)
        let contentCreator = UILabel(frame: creatorFrame)
        contentCreator.text = self.contentProfile.creator
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
        commentLabel.text = "\(contentProfile.likes)"
        commentLabel.textAlignment = NSTextAlignment.Left
        commentLabel.textColor = themeColor
        commentLabel.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 18)
        
        titleView.addSubview(commentLabel)
        
        //buttons
        let imageSize:CGFloat = 20
        //like button
        xLocation -= (buffer + imageSize)
        var likeImage = UIImage()
        if contentProfile.liked {
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
        if contentProfile.liked {
            contentProfile.liked = false
            likeButton.setImage(UIImage(named: "unlikedStar"), forState: .Normal)
            contentManager.profileDisliked(self.contentProfile)
        } else {
            contentProfile.liked = true
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
    func picture() -> UIImageView{
        let pictureFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height / 2)
        let imageFrame = pictureFrame
        let imageView = UIImageView(frame: imageFrame)
        imageView.image = self.contentProfile.contentImage
        imageView.contentMode = UIViewContentMode.ScaleToFill
        return imageView
    }
    
    func website()-> UIWebView{
        let webViewFrame = CGRectMake(0 , 0 , self.frame.width, self.frame.height - titleHeight)
        let webView = UIWebView(frame: webViewFrame)
        let url:NSURL = self.contentProfile.link
        
        webView.loadRequest(NSURLRequest(URL: url)) // shows the webpage, but you don't get the content, less capabiltities
        
       /* let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data , response , error) -> Void in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding) // decode website data
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    webView.loadHTMLString(String(webContent), baseURL: nil)
                })
            } else { print("Error \(error)") }
        }*/
        //task.resume()
        return webView
    }
}
