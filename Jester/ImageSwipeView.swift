//
//  ImageProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 7/26/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//
import UIKit
@IBDesignable class ImageSwipeView: ContentView{

    var view:UIView!
    
    var contentProfile:ContentProfile!
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
    }

     init(frame: CGRect, contentProfile:ContentProfile){
        super.init(frame: frame)
        self.contentProfile = contentProfile
        setup()
        update()
    }
     override func update(){
        imageView.image = contentProfile.contentImage
        caption.text = contentProfile.caption

    }
    func setup()
    {
        //TODO issue with dragging and view changing due to changing sizes 
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        addSubview(view)

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