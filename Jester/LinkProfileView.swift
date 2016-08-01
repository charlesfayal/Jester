//
//  LinkProfileView.swift
//  Jester
//
//  Created by Charles Fayal on 7/26/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import Foundation
class LinkProfileView: ContentProfileView{
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
}