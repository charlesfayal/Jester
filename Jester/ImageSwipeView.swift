//
//  ImageProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 7/26/16.
//  Copyright © 2016 Steven Graf & Charles Fayal. All rights reserved.
//
import UIKit
@IBDesignable class ImageSwipeView: SwipeView{

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //This makes it editbable in the storyboard, worth doing for all of them?
    @IBInspectable
    var myCaptionText: String? {
        get {
            return caption.text
        }
        set(myCaptionText) {
            caption.text = myCaptionText
        }
    }
    

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        print("initialzied from coder?")
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
     override init(frame: CGRect, contentProfile:ContentProfile){
        super.init(frame: frame, contentProfile:contentProfile)
        self.contentProfile = contentProfile
        print("initialzied from frame, contentProfile")
        setup()
        update()
    }
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func update(){
        super.update()
        imageView.image = contentProfile.contentImage
        caption.text = contentProfile.caption
<<<<<<< HEAD
        caption.sizeToFit()
        heightConstraint.constant = caption.frame.height
=======
        print("caption text: \(contentProfile.caption)")
        if contentProfile.caption == "" {
            imageView.frame = CGRectMake(10, 78, 355, 579)
            caption.hidden = true
        } else {
            print("caption height \(caption.frame.height)")
            caption.sizeToFit()
            let height = caption.frame.height
            caption.frame = CGRectMake(5, contentView.frame.height - height, contentView.frame.width, height)
            imageView.frame = CGRectMake(0, 0, contentView.frame.height, contentView.frame.height - height)
            imageView.updateConstraints()
            print("caption height after adjusting size \(height)")
        }
  

>>>>>>> Screen-size-change
    }
    
    
    func setup()
    {
        //TODO issue with dragging and view changing due to changing sizes 
        self.view = loadViewFromNib()
        view.frame = bounds
        print("views frame \(view.frame)")
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        super.Setup()
        self.addSubview(view)

        
       // self.layer.cornerRadius = 10
    }
    
    /**
     Function used to load a view from a .xib function
     Must be used before any of the labels, image views etc used
    */
     func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "ImageSwipeView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
}