//
//  ContentProfile.swift
//  Jester
//
//  Created by Charles Fayal on 7/15/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import Foundation
import UIKit
import Parse
enum contentType : String{
    case link = "link"
    case picture = "picture"
    case nothing = "nothing"
}
class ContentProfile {
    //General
    var parseObject:PFObject!
    var objectId:String = ""
    var type:contentType = .nothing
    var caption:String = ""
    var creator:String = ""
    var likes = [String]()
    /*weak*/ var swipeView:SwipeView!
    
    var liked:Bool = false
    
    var previousProfile:ContentProfile!
    var nextProfile:ContentProfile!
    //Link
    var link:NSURL = NSURL()
    //Image
    var contentImage:UIImage!
    init(){
        
    }
    init(type:contentType){
        self.type = type
    }
    func setImage(image: UIImage){
        contentImage = image
        if swipeView != nil {
            swipeView.update()
            print("\(self.objectId) - image added and view updated")
        } else {
            print("\(self.objectId) - image added but no view")

        }
    }
    func getSwipeView(swipeScreen: MainScreenViewController)->SwipeView{
        
        if swipeView == nil {
            print("\(self.objectId) - creating swipe view")
            createSwipeView(swipeScreen)
        }
        swipeView.frame = swipeScreen.profileView.frame
        swipeView.update()
        return swipeView
    }
    func createSwipeView(swipeScreen: MainScreenViewController) {
        let swipeFrame = swipeScreen.profileView.frame

        if swipeView == nil {
            switch self.type {
            case .picture:
                print("\(self.objectId) - creating image swipe view")
                swipeView = ImageSwipeView(frame: swipeFrame , contentProfile: self)
            case .link:
                print("link type")
                swipeView = LinkSwipeView(frame: swipeFrame , contentProfile: self)
                
            case .nothing:
                print("nothing as type")
            }
        }
        if swipeView == nil { print( "\(self.objectId) issue creating swipe view") }
    }
}