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
    //self.layer.cornerRadius = 10
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
    
  
    //titel frame
    let titleHeight: CGFloat = 30

    let titleFrame =   CGRectMake(0, yLocation, self.frame.width , titleHeight)
    let titleView = UIView(frame: titleFrame)
   
    //Username
    let creatorFrame = CGRectMake(2, 0, self.frame.width / 2 , titleHeight)
    let contentCreator = UILabel(frame: creatorFrame)
    contentCreator.text = "Chf11002"
    titleView.addSubview(contentCreator)
    
    //Likes
    let likesFrame = CGRectMake((self.frame.width / 2), 0, (self.frame.width / 2) - titleHeight, titleHeight)
    let contentLikes = UILabel(frame: likesFrame)
    contentLikes.text = "1623"
    contentLikes.textAlignment = NSTextAlignment.Right
    contentLikes.textColor = UIColor.grayColor()
    titleView.addSubview(contentLikes)
    
    //award image
    let awardImage:UIImage = UIImage(named:"likesImage")!
    let awardFrame = CGRectMake(self.frame.width - titleHeight, 6 , titleHeight - 12, titleHeight - 12)
    let awardView = UIImageView(frame: awardFrame)
    awardView.image = awardImage
    titleView.addSubview(awardView)

    
     self.addSubview(titleView)
    yLocation += titleHeight

    
    let messageFrame = CGRectMake(0, yLocation, self.frame.width, self.frame.height - yLocation)
    let contentMessage = UITextView(frame: messageFrame)
    contentMessage.text = "This is where the text will go for the message, this pic of me being a total bad ass ya know? like wooooo. And Just like pow and swooosh and the waves were like shooooo sham bam booom.";
    contentMessage.font = UIFont(name: "Verdana" , size: 20)
    contentMessage.textColor = UIColor.darkGrayColor()
    self.addSubview(contentMessage)
    
    self.userInteractionEnabled = true

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
        let webViewFrame = CGRectMake(0 , 0 , self.frame.width, self.frame.height)
        let webView = UIWebView(frame: webViewFrame)
        let url = NSURL(string: "http://stackoverflow.com/questions/24339145/how-do-i-write-a-custom-init-for-a-uiview-subclass-in-swift")! // converts to a url
        
        // webView.loadRequest(NSURLRequest(URL: url)) // shows the webpage, but you don't get the content, less capabiltities
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data , response , error) -> Void in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding) // decode website data
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    webView.loadHTMLString(String(webContent!), baseURL: nil)
                })
            } else { print("Error \(error)") }
        }
        task.resume()
        return webView
    }
}
