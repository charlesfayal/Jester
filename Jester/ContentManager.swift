//
//  contentManager.swift
//  Jester
//
//  Created by Charles Fayal on 7/19/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Foundation
import Parse

class ContentManager{
    
    static let sharedInstance = ContentManager() //Singleton instance
    
    var swipeScreen:MainScreenViewController!
    var topProfile:ContentProfile!
    enum Arrays {
        case profilesOnDeck
        case usersPosts
        case likedPosts
    }
    var profilesOnDeck = [ContentProfile]()
    var usersPosts = [ContentProfile]()
    var likedPosts = [ContentProfile]()
    var seenProfiles = [String]()

    

    

    //MARK Swipe screen functions
    func nextProfile(){
        if let nextProfile = topProfile.nextProfile{
            if !profilesOnDeck.isEmpty{
                profilesOnDeck.removeFirst()
            }
            changeTopProfile(nextProfile)
        } else { print("no more profiles, trying to update") }
        updateProfiles()
    }

    func previousProfile() {
        if let previousProfile = topProfile.previousProfile {
            changeTopProfile(previousProfile)
            profilesOnDeck.insert(previousProfile, atIndex: 0)
        } else { print("no previous profile") }
    }
    
    func changeTopProfile(newTopProfile : ContentProfile){
        swipeScreen.changeTopProfileView(newTopProfile)
        topProfile = newTopProfile
    }
    
    func profileLiked(contentProfile:ContentProfile){
        PFUser.currentUser()!.addUniqueObjectsFromArray([contentProfile.objectId], forKey: "liked")
        PFUser.currentUser()?.saveInBackground()
    }
    func profileDisliked(contentProfile:ContentProfile){
        PFUser.currentUser()?.removeObjectsInArray([contentProfile.objectId], forKey: "liked")
        PFUser.currentUser()?.saveInBackground()

    }
    //MARK Saving data to Parse
    func newPost(contentProfile: ContentProfile, sender: ParseViewController){
        
            let post = PFObject(className: "ContentProfile")
            post["caption"] = contentProfile.caption
            let creator = contentProfile.creator//PFUser.currentUser()?.valueForKey("name")
            post["creator"] = creator
            post["likes"] = contentProfile.likes
        
    
            switch contentProfile.type {
            case .picture:
                print("saving a picture profile")
                let imageData = UIImageJPEGRepresentation(contentProfile.contentImage, 0.8)
                let imageFile = PFFile(name: "image.jpeg", data: imageData!)
                post["imageFile"] = imageFile
            case .link:
                print("saving a link profile")
            case .nothing:
                print("saving a profile marked as nothing")
                
            }
            post["contentType"] = "picture"
            post.saveInBackgroundWithBlock { (success, error) in
            sender.stopActivityIndicator()
            if success {
                print("post successful")
                print("saved \(post.objectId!) to \(PFUser.currentUser()?.objectId!)")
                PFUser.currentUser()?.addUniqueObjectsFromArray([post.objectId!], forKey: "usersPosts")
                PFUser.currentUser()?.saveInBackground()
                //                do{ try PFUser.currentUser()?.save() } catch { print("problem with  choosen saving") }
                
                sender.displayAlert("Content Posted!", message: "Your content has been successfully posted")
                sender.performSegueWithIdentifier("unwindToMainScreen", sender: self)
                
            } else {
                sender.displayAlert("Could not post content", message: "Please try again")
                
            }
        }
    }
    //MARK liked profiles functions
    func updateLikedPosts()-> [ContentProfile]{
        if PFUser.currentUser()?.objectForKey("liked") != nil {
            let usersPostsObjectIds = PFUser.currentUser()?.objectForKey("liked") as! [String]
            print(usersPostsObjectIds)
            let profileQuery = PFQuery(className: "ContentProfile")
            profileQuery.whereKey("objectId", containedIn: usersPostsObjectIds)
            //profileQuery.whereKey("objectId", notContainedIn: ) posts we already have
            performQueryForProfiles(profileQuery, arrayToAddTo: .likedPosts)
        }
        return likedPosts

    }
    //MARK getting profiles functions
    /**
     returns an array of the profiles that the users has posted
    */
    func updateUsersPosts()->[ContentProfile]{
        if PFUser.currentUser()?.objectForKey("usersPosts") != nil {
            let usersPostsObjectIds = PFUser.currentUser()?.objectForKey("usersPosts") as! [String]
            print(usersPostsObjectIds)
            let profileQuery = PFQuery(className: "ContentProfile")
            profileQuery.whereKey("objectId", containedIn: usersPostsObjectIds)
            //profileQuery.whereKey("objectId", notContainedIn: ) posts we already have
            performQueryForProfiles(profileQuery, arrayToAddTo: .usersPosts)
        }
        return usersPosts
    }
    /**
     Gets new profiles if needed for the main swipe screen
    */
    func updateProfiles(){
        print("update")
        if profilesOnDeck.count < 4 {
           getProfiles()
        }
    }
    
    /**
     Queries for new ContentProfiles
    */
    func getProfiles(){
        let profileQuery = PFQuery(className: "ContentProfile")
        profileQuery.whereKey("objectId", notContainedIn: seenProfiles)
        profileQuery.limit = 4 - profilesOnDeck.count
        performQueryForProfiles(profileQuery, arrayToAddTo: .profilesOnDeck)
    }
    func performQueryForProfiles(query: PFQuery, arrayToAddTo:Arrays ){
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                print(error)
            } else {
                for object in objects!{
                    if !self.seenProfiles.contains(object.objectId!){
                        self.seenProfiles.append(object.objectId!)
                    }
                    let newProfile = self.createProfileFromObject(object)
                    switch( arrayToAddTo){
                    case .profilesOnDeck:
                            self.addToProfilesOnDeck(newProfile)
                    case .usersPosts:
                            self.usersPosts.append(newProfile)
                    case .likedPosts:
                            self.likedPosts.append(newProfile)
                    }
                }
            }
        }

    }
    func createProfileFromObject(object:PFObject)-> ContentProfile{
        //print(object)
        var newProfile = ContentProfile()
        switch object["contentType"] as! String {
        case contentType.link.rawValue:
            print("post is link")
        case contentType.picture.rawValue:
            print("post is image")
            newProfile = self.createImageProfileFromObject(object)
        default:
            print("post content type was not specified")
        }
        return newProfile

    }
    /**
     uploads a profiles image
    */
    func createImageProfileFromObject(object:PFObject) -> ContentProfile{
        let newProfile = ContentProfile(type: contentType.picture)
        if object["caption"] != nil {
            newProfile.caption = object["caption"] as! String
        } else { print("no caption")}
        if object["creator"] != nil {
            newProfile.creator = object["creator"] as! String
        } else { print("no creator") }
        newProfile.objectId = object.objectId!
        if object["likes"] != nil {
            newProfile.likes = object["likes"] as! [String] //Possible error as it is just and array in Parse
           
        } else { print( "no likes") } 
        uploadImageToProfile(object, contentProfile: newProfile)
        return newProfile
    }
    func uploadImageToProfile(profile:PFObject , contentProfile: ContentProfile)  {
        print("getting profile's image")
        if let imageFile = profile["imageFile"] {
            imageFile.getDataInBackgroundWithBlock({ (imageData, error) in
                if error != nil {
                    print(error)
                } else {
                    if let data = imageData {
                        contentProfile.contentImage = UIImage(data: data)! // these could use error protection
                    }
                }
            })
        }
    }

    /**
     creates a new profile view
     */
    func addToProfilesOnDeck(newProfile:ContentProfile){
        print("adding profile \(newProfile.objectId) deck count : \( profilesOnDeck.count )")
        if profilesOnDeck.isEmpty {
            swipeScreen.changeTopProfileView(newProfile)
            if topProfile == nil {
                topProfile = newProfile
            }
        } else {
            let lastProfile = profilesOnDeck.last
            lastProfile!.nextProfile = newProfile
            newProfile.previousProfile = lastProfile
        }
        profilesOnDeck.append(newProfile)
    }
}