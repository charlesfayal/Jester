//
//  ImageProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 7/26/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//
import UIKit
class ImageProfileView: ContentProfileView {
    
    @IBOutlet weak var image: UIImageView!
    
    var imageView:UIImageView!
    var captionView:UILabel!
    override init(frame:CGRect, contentProfile:ContentProfile, swipeScreen:MainScreenViewController){
        super.init(frame: frame, contentProfile: contentProfile, swipeScreen: swipeScreen)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func nibSetup(){
        //creates the views such as the image view and caption
        print("\(contentProfile.objectId) initializing image profile view")
        let pictureFrame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height / 2)
        let imageFrame = pictureFrame
        imageView = UIImageView(frame: imageFrame)
        imageView.image = self.contentProfile.contentImage
        imageView.contentMode = UIViewContentMode.ScaleToFill
        self.addSubview(imageView)
        
        
        let captionFrame = CGRect(x: 0, y: imageFrame.height, width: contentView.frame.width, height: contentView.frame.height - imageFrame.height)
        captionView = UILabel(frame: captionFrame)
        captionView.text = contentProfile.caption
        captionView.sizeToFit()
        self.addSubview(captionView)
    }
    override func update(){
        super.update()
        imageView.image = contentProfile.contentImage
        captionView.text = contentProfile.caption
        
    }

}