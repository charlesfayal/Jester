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
    //MARK Managers
    
    //MARK Gesture Intializers
    var swipeGesture: UIPanGestureRecognizer!
    var tapGesture:UITapGestureRecognizer!
    //MARK IBOutlets
    @IBOutlet weak var categoriesOutlet: UIButton!
    var originalCenter:CGPoint = CGPoint()
    
    var topProfileView:ContentProfileView!
    var profilesOnDeck = [ContentProfileView]()
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var profileView: UIView!
    //MARK: Navigational Buttons
    // used to get back to main screen
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue )
    {
    //reload content
    }
    @IBAction func postButton(sender: AnyObject) { }
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
    func changeTopProfileView(profile:ContentProfile){
        print("\(profile.objectId) became top profile view")
        if topProfileView != nil {
            topProfileView.removeFromSuperview()
        }
        topProfileView = profile.createView(profileView.frame, swipeScreen: self)
        self.addSwipeGesture(topProfileView)
        self.addTapGesture(topProfileView.contentView)
        self.view.addSubview(topProfileView)
    }

    var updateTimer = NSTimer()
    func updateProfiles(){
        contentManager.updateProfiles() // gets profiles
        
    }
    override func viewWillAppear(animated: Bool) {
        updateProfiles()
        //updateTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(MainScreenViewController.updateProfiles), userInfo: nil, repeats: true)
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        
        contentManager.swipeScreen = self
        originalCenter = profileView.center // used for after drag

        // Gestures
         swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(MainScreenViewController.wasDragged(_:)))
         tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainScreenViewController.wasTapped(_:)))
    
        //UI adjustments
        let frame = categoriesOutlet.frame
        categoriesOutlet.frame = CGRectMake(frame.minX,frame.minY,self.view.frame.width / 2, frame.height)
        categoriesOutlet.layer.borderWidth = 1
        categoriesOutlet.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        updateTimer.invalidate()

    }
    
    //MARK: -Gestures
    func wasDragged(gesture: UIPanGestureRecognizer)
    {
        let translation = gesture.translationInView(self.view)
        let view = gesture.view! as! ContentProfileView
        view.center = CGPoint(x: profileView.center.x + translation.x, y: self.profileView.center.y + translation.y) // relative to bottom left of screen
        let xFromCenter = view.center.x - self.view.bounds.width/2
        let scale = 100 / (abs(xFromCenter) + 100 )
        var rotation = CGAffineTransformMakeRotation(0)
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        view.transform = stretch
        if gesture.state == UIGestureRecognizerState.Ended {
            if view.center.x < 100 {
                print("left drag - next profile")
                contentManager.nextProfile()
            } else if view.center.x > self.view.bounds.width - 100 {
                print("right drag - previous profile")
                contentManager.previousProfile()
            }
            rotation = CGAffineTransformMakeRotation(0)
            stretch = CGAffineTransformScale(rotation, 1, 1)
            view.transform = stretch
            view.center = originalCenter
        }
    }
    
    func wasTapped(gesture: UITapGestureRecognizer)
    {
        print("was tapped")
        
        selectedPost = topProfileView.contentProfile
        self.performSegueWithIdentifier("toPostInfo", sender: self)
    }
    func addTapGesture(view: UIView){
        view.addGestureRecognizer(tapGesture)
    }
    func addSwipeGesture(view:UIView){
        view.addGestureRecognizer(swipeGesture)
        
    }

    
}
