//
//  ContentProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 6/30/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
enum contentType {
    case link
    case picture
    case nothing
}
class ContentProfileView: UIView {
    var profileType: contentType = .nothing
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
    init(frame: CGRect, type: contentType){
        
        profileType = type
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
    print("profile sizes \(self.frame.height) \(self.frame.width)")

    var contentView = UIView()
    
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
        contentMessage.text = "This is where the text will go for the message, this pic of me being a total bad ass ya know? like wooooo. And Just like pow and swooosh and the waves were like shooooo sham bam booom.";
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
        //Username
        let creatorFrame = CGRectMake(2, 0, self.frame.width / 2 , titleHeight)
        let contentCreator = UILabel(frame: creatorFrame)
        contentCreator.text = "Chf11002"
        contentCreator.textColor = themeColor
        contentCreator.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 16)
        titleView.addSubview(contentCreator)
        
        let buffer:CGFloat = 10
        var xLocation = titleFrame.width - buffer
        //Likes
        let likesLength:CGFloat = 60
        xLocation -= likesLength
        let likesFrame = CGRectMake(xLocation, 0, likesLength, titleHeight)
        let contentLikes = UILabel(frame: likesFrame)
        contentLikes.text = "1623"
        contentLikes.textAlignment = NSTextAlignment.Left
        contentLikes.textColor = themeColor
        contentLikes.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 16)
        
        titleView.addSubview(contentLikes)
        
        //buttons
        let imageSize:CGFloat = 20
        //lie button
        xLocation -= (buffer + imageSize)
        var likeImage: UIImage = UIImage()
        if let image = UIImage(named:"unlikedStar") {
           likeImage = image
        } else { print("issue with likes image") }
        let likeFrame = CGRectMake(xLocation , 8 , imageSize, imageSize)
        let likeView = UIImageView(frame: likeFrame)
        likeView.image = likeImage
        titleView.addSubview(likeView)
        
        //comment image 
        xLocation -= (buffer + imageSize)
        var buttonImage: UIImage = UIImage()
        if let image = UIImage(named:"commentButton") {
            buttonImage = image
        } else { print("issue with button image") }
        let buttonFrame = CGRectMake(xLocation , 8 , imageSize, imageSize)
        let buttonView = UIImageView(frame: buttonFrame)
        buttonView.image = buttonImage
        titleView.addSubview(buttonView)
        
        //comment image
        xLocation -= (buffer + imageSize)
        var shareImage: UIImage = UIImage()
        if let image = UIImage(named:"shareButton") {
            shareImage = image
        } else { print("issue with button image") }
        let shareFrame = CGRectMake(xLocation , 8 , imageSize, imageSize)
        let shareView = UIImageView(frame: shareFrame)
        shareView.image = shareImage
        titleView.addSubview(shareView)
        
        
        return titleView
    }
    func picture() -> UIImageView{
        let pictureFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height / 2)
        let imageFrame = pictureFrame
        let imageView = UIImageView(frame: imageFrame)
        imageView.image = UIImage(named:"Default Image")
        imageView.contentMode = UIViewContentMode.ScaleToFill
        return imageView
    }
    
    func website()-> UIWebView{
        let webViewFrame = CGRectMake(0 , 0 , self.frame.width, self.frame.height - titleHeight)
        let webView = UIWebView(frame: webViewFrame)
        let url = NSURL(string: "https://www.google.com/?gws_rd=ssl")! // converts to a url
        
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
