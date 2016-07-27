//
//  PersistenceManager.swift
//  Jester
//
//  Created by Charles Fayal on 7/26/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import Foundation
class PersistenceManager {
    static let sharedInstance = PersistenceManager() //Singleton instance
    var likedProfiles = [ContentProfile]()
    var usersPosts = [ContentProfile]()
    
}