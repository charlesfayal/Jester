//
//  TestViewController.swift
//  Jester
//
//  Created by Charles Fayal on 7/7/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    override func viewDidAppear(animated: Bool) {
        // 1
        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        
      
    }
    override func viewWillAppear(animated: Bool) {
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        if  let image = UIImage(named: "camera")
        {
            print("worked")
            imageView.image = image
            
        }else
        {
            print("didnt work")
            imageView.image =  UIImage(named: "Profile.png")
        }
        self.navigationItem.titleView = imageView
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
