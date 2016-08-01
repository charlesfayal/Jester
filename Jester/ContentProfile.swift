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
    /*weak*/ var contentView:ContentProfileView!
    
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
        if contentView != nil {
            contentView.contentProfile = self
            contentView.update()
            print("\(self.objectId) image added and view updated")
        } else {
            print("\(self.objectId) image added but no view")

        }
    }
    func createView(frame:CGRect, swipeScreen: MainScreenViewController) -> ContentProfileView{
        if contentView == nil {
            switch self.type {
            case .picture:
                contentView = ImageProfileView(frame: frame, contentProfile:self, swipeScreen: swipeScreen)
            case .link:
                print("link type")
                contentView = LinkProfileView(frame: frame, contentProfile:self, swipeScreen: swipeScreen)
            case .nothing:
                print("nothing as type")
            }
        }
        return contentView

    }
}