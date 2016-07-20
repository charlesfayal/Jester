//
//  MainScreenViewController.swift
//  Jester
//
//  Created by Charles Fayal on 6/29/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
import Parse
var selectedPost:ContentProfile!
class MainScreenViewController: UIViewController, UIGestureRecognizerDelegate {
    //MARK Gesture Intializers
    var swipeGesture: UIPanGestureRecognizer!
    var tapGesture:UITapGestureRecognizer!
    //MARK IBOutlets
    @IBOutlet weak var categoriesOutlet: UIButton!
    var originalCenter:CGPoint = CGPoint()
    var nextProfile:ContentProfileView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var profileView: UIView!
    //MARK: Navigational Buttons
    // used to get back to main screen
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue )
    {
    //reload content
    }
    
   
    @IBAction func postButton(sender: AnyObject) {
        
        //self.performSegueWithIdentifier("toCreatePost", sender: self)
    }

    @IBAction func categoriesButton(sender: AnyObject)
    {
        self.performSegueWithIdentifier("toCategories", sender: self)
    }
    
    @IBAction func likeButon(sender: AnyObject)
    {
    }
    @IBAction func dislikeButton(sender: AnyObject)
    {
    }
    
    @IBAction func commentButton(sender: AnyObject)
    {

        self.performSegueWithIdentifier("toComments", sender: self)
    }
    
    @IBAction func shareButton(sender: AnyObject)
    {
    }

    func addPost(contentProfile: ContentProfile){
        
    }
    func wasDragged(gesture: UIPanGestureRecognizer)
    {
        let translation = gesture.translationInView(self.view)
        let view = gesture.view!
        view.center = CGPoint(x: profileView.center.x + translation.x, y: self.profileView.center.y + translation.y) // relative to bottom left of screen
        
        let xFromCenter = view.center.x - self.view.bounds.width/2
        let scale = 100 / (abs(xFromCenter) + 100 )
        var rotation = CGAffineTransformMakeRotation(0)
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        view.transform = stretch
        if gesture.state == UIGestureRecognizerState.Ended {
            if view.center.x < 100 {
                print("left drag")
                view.hidden = true
                //nextProfile.hidden = false
                
            } else if view.center.x > self.view.bounds.width - 100 {
                print("right drag")
            }
            rotation = CGAffineTransformMakeRotation(0)
            stretch = CGAffineTransformScale(rotation, 1, 1)
            view.transform = stretch
            view.center = originalCenter
            
            
        }
        // print(translation)
    }
    func wasTapped(gesture: UITapGestureRecognizer)
    {
        let view = gesture.view as! ContentProfileView
        selectedPost = view.contentProfile
        self.performSegueWithIdentifier("toPostInfo", sender: self)
    }
   // var profiles = [String:ContentProfile]()
    func getProfiles(){
        let profileQuery = PFQuery(className: "ContentProfile")
        profileQuery.limit = 4
        profileQuery.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                print(error)
            } else {
                for object in objects!{
                    print(object)
                    switch object["contentType"] as! String {
                    case contentType.link.rawValue:
                        print("post is link")
                    case contentType.picture.rawValue:
                        print("post is image")
                        self.getProfileImages(object)
                    default:
                        print("post content type was not specified")
                    }
                }
            }
        }
    }
    func getProfileImages(profile: PFObject) {
        print("getting profile images")
        //let profileId = profile.objectId
        if let imageFile = profile["imageFile"] {
            imageFile.getDataInBackgroundWithBlock({ (imageData, error) in
                if error != nil {
                    print(error)
                } else {
                    if let data = imageData {
                        let newProfile = ContentProfile(type: contentType.picture)
                        newProfile.contentImage = UIImage(data: data)!
                        newProfile.caption = profile["caption"] as! String
                        newProfile.creator = profile["creator"] as! String
                        let likes = profile["likes"]
                        newProfile.likes = "\(likes)"
                        //self.profiles[profile.objectId!] = newProfile
                        self.addProfileView(newProfile)
                    }
                }
            })
        }
    }
    func addProfileView(contentProfile:ContentProfile){
        let profile = ContentProfileView(frame: profileView.frame, type: .picture, contentProfile:contentProfile , delegate: self)
        profile.addGestureRecognizer(swipeGesture)
        profile.addGestureRecognizer(tapGesture)
        self.view.addSubview(profile)
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        // Gestures
         swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(MainScreenViewController.wasDragged(_:)))
         tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainScreenViewController.wasTapped(_:)))
        
        let frame = categoriesOutlet.frame
        categoriesOutlet.frame = CGRectMake(frame.minX,frame.minY,self.view.frame.width / 2, frame.height)
        categoriesOutlet.layer.borderWidth = 1
        //categoriesOutlet.layer.cornerRadius = 5
        
        categoriesOutlet.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
        
        originalCenter = profileView.center

        //Add a profile
        /*
        let contentProfile = ContentProfile(type: .link)
        let profile = ContentProfileView(frame: profileView.frame, type: .link, contentProfile:contentProfile , delegate: self)
        profile.addGestureRecognizer(swipeGesture)
        profile.addGestureRecognizer(tapGesture)
        self.view.addSubview(profile)*/
        
        
        getProfiles()
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation


}
