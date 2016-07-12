//
//  MainScreenViewController.swift
//  Jester
//
//  Created by Charles Fayal on 6/29/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var originalCenter:CGPoint = CGPoint()

    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var profileView: UIView!
    //MARK: Navigational Buttons
    // used to get back to main screen
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue )
    {
    //reload content
    }
    @IBOutlet weak var categoriesOutlet: UIButton!
    
    @IBOutlet weak var postButtonOutlet: UIButton!
   
    @IBAction func postButton(sender: AnyObject) {
        self.performSegueWithIdentifier("toPost", sender: self)
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

    func wasDragged(gesture: UIPanGestureRecognizer)
    {
        let translation = gesture.translationInView(self.view)
        let view = gesture.view!
        view.center = CGPoint(x: self.view.bounds.width/2 + translation.x, y: self.view.bounds.height/2 + translation.y) // relative to bottom left of screen
        let xFromCenter = view.center.x - self.view.bounds.width/2
        let scale = 100 / (abs(xFromCenter) + 100 )
        var rotation = CGAffineTransformMakeRotation(xFromCenter / (self.view.bounds.width/2))
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        view.transform = stretch
        if gesture.state == UIGestureRecognizerState.Ended {
            if view.center.x < 100 {
                print("left drag")
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
        let view = gesture.view //make content profile to get data
        self.performSegueWithIdentifier("toPostInfo", sender: self)
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        //UI runtime changes
        //buttonsView.layer.borderWidth = 1
        //buttonsView.layer.borderColor = UIColor.grayColor().CGColor
        
        
      
        
        let frame = categoriesOutlet.frame
        categoriesOutlet.frame = CGRectMake(frame.minX,frame.minY,self.view.frame.width / 2, frame.height)
        categoriesOutlet.layer.borderWidth = 1
        //categoriesOutlet.layer.cornerRadius = 5
        
        categoriesOutlet.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
        
        originalCenter = profileView.center
        // Gestures
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(MainScreenViewController.wasDragged(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainScreenViewController.wasTapped(_:)))
        //Add a profile
        print("here")
        let profile = ContentProfileView(frame: profileView.frame, type: .link)
        print("here too")
        profile.addGestureRecognizer(swipeGesture)
        profile.addGestureRecognizer(tapGesture)
        self.view.addSubview(profile)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
