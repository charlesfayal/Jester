//
//  ImageProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 7/26/16.
//  Copyright © 2016 Steven Graf & Charles Fayal. All rights reserved.
//
import UIKit
@IBDesignable class ImageSwipeView: SwipeView {

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
        caption.sizeToFit()
        heightConstraint.constant = caption.frame.height
        
    }
    
    
    func setup()
    {
        self.view = loadViewFromNib()
        view.frame = bounds
        print("views frame \(view.frame)")
        //view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
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