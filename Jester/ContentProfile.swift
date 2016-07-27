//
//  ContentProfile.swift
//  Jester
//
//  Created by Charles Fayal on 7/15/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import Foundation
import UIKit
enum contentType : String{
    case link = "link"
    case picture = "picture"
    case nothing = "nothing"
}
class ContentProfile {
    //General
    var objectId:String = ""
    var type:contentType = .nothing
    var caption:String = ""
    var creator:String = ""
    var likes = [String]()
    
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
    
}