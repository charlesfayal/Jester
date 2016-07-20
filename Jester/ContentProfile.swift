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
    var type:contentType = .nothing
    var caption:String = "This is the default caption"
    var creator:String = "StevyCreator"
    var likes:String = "1622"
    //Link
    var link:NSURL = NSURL(string: "https://Google.com")!
    //Image
    var contentImage:UIImage = UIImage(named: "Default Image")!
    
    init(type:contentType){
        self.type = type
    }
    
}