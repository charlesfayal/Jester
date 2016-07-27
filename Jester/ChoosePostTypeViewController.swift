//
//  CreateContentViewController.swift
//  Jester
//
//  Created by Charles Fayal on 7/15/16.
//  Copyright © 2016 Charles Fayal. All rights reserved.
//

import UIKit
var selectedImage:UIImage!
class ChoosePostTypeViewController: UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    //MARK Buttons
    @IBAction func creatLinkButton(sender: AnyObject) {
    }
    
    @IBAction func createImageButton(sender: AnyObject) {
        chooseImage(self)
    }
    //MARK Image functions
    @IBAction func chooseImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
         self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true) { 
            selectedImage =  image
            print("Selected image")
            self.performSegueWithIdentifier("toAddComment", sender: self)
        }
   
    }
    //MARK Link option functions
    

    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
       /* let dest = segue.destinationViewController
        if dest.isKindOfClass(AddCommentViewController) {
            let commentController = dest as! AddCommentViewController
            let image = imageToPost
            
            commentController.postImage!.image = image
        }*/
    }*/
    

}
