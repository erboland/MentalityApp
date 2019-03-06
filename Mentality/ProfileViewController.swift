//
//  ProfileViewController.swift
//  Mentality
//
//  Created by Ербол Каршыга on 7/25/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit
import KFSwiftImageLoader
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    lazy var defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = CAGradientLayer().turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        self.tabBarController?.tabBar.barStyle = .Black
        if defaults.stringForKey("user_name") != nil {
            self.userNameTextField.text! = defaults.stringForKey("user_name")!
        }
    }
    
    // MARK:- IBActions
    
    @IBAction func updateButton(sender: UIButton) {
        guard userNameTextField.text!.characters.count > 0 else {
            alertOccure("Please type your user name")
            return
        }
        alertOccure("user name is updated")
        defaults.setValue(userNameTextField.text!, forKey: "user_name")
    }
   
    @IBAction func logOutButton(sender: UIButton) {
        try! FIRAuth.auth()!.signOut()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("uid")
        NSUserDefaults.standardUserDefaults().synchronize()
    self.performSegueWithIdentifier("unwindToRegistration", sender: self)
    }
    
    @IBAction func imagePickerGR(sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        //imagePicker.sourceType = .Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
   
    // MARK:- Image Picker Controller Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.profileImageView.contentMode = .ScaleAspectFill
        self.profileImageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK:- Alert occure
    func alertOccure(text: String) {
        let alert = UIAlertController(title: "Oops", message: text, preferredStyle: .Alert)
        let ok_button = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok_button)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToRegistration" {
            let regVC = segue.destinationViewController as! RegistrationViewController
            regVC.userNameTextField.text = defaults.stringForKey("user_name")
        }
    }
}
