//
//  LinkProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 7/26/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
@IBDesignable class LinkSwipeView: SwipeView{
    
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var webView: UIWebView!
    /*
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
 */
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
        print("initialzied from frame, contentprofile")
        setup()
        update()
    }
    override func update(){
        super.update()
        let request = NSURLRequest(URL: contentProfile.link)
        webView.loadRequest(request) // may be able to do this with just html to make it quicker
        self.caption.text = contentProfile.caption
        
    }
    func setup()
    {
        //TODO issue with dragging and view changing due to changing sizes
        self.view = loadViewFromNib()
        view.frame = bounds
        print("views frame \(view.frame)")
        //view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        super.Setup()
        self.addSubview(view)
    }
    
    /**
     Function used to load a view from a .xib function
     Must be used before any of the labels, image views etc used
     */
    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "LinkSwipeView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
}