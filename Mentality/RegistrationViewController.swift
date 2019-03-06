
//
//  RegistrationViewController.swift
//  Mentality
//
//  Created by Ербол Каршыга on 7/25/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit
import Firebase
class RegistrationViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    var defaults = NSUserDefaults.standardUserDefaults()
    var ref: FIRDatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = CAGradientLayer().turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        self.tabBarController?.tabBar.barStyle = .Black
        self.ref = FIRDatabase.database().reference()
    }
    // MARK: - IBActions
    @IBAction func signInButton(sender: UIButton) {
        guard let email = emailTextField.text, password = passwordTextField.text where emailTextField.text!.characters.count > 0 && passwordTextField.text!.characters.count > 0 && userNameTextField.text!.characters.count > 0 else {
            self.alertOccure("Please enter your email, username and password")
            return
        }
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            if error != nil {
                self.alertOccure("\(error!.localizedDescription)")
                self.passwordTextField.text = ""
            } else {
                let userID = FIRAuth.auth()?.currentUser?.uid
                NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "uid")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.performSegueWithIdentifier("Tab_Segue", sender: nil)
                
            }
        }
    //    setUpDatabase(user_name: userNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
    }
    @IBAction func signUpButton(sender: UIButton) {
        guard let email = emailTextField.text, password = passwordTextField.text where emailTextField.text!.characters.count > 0 && passwordTextField.text!.characters.count > 0  else {
            self.alertOccure("Please enter your email, username and password")
            return
        }
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) in
            if error != nil {
                self.alertOccure("\(error!.localizedDescription)")
                print(error)
                self.passwordTextField.text = ""
            } else {
                let userID = FIRAuth.auth()?.currentUser?.uid
                NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "uid")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.performSegueWithIdentifier("Tab_Segue", sender: nil)
            }
        }
       // setUpDatabase(user_name: userNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
    }
    @IBAction func unwindToRegistration(segue: UIStoryboardSegue) {}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Tab_Segue" {
            defaults.setInteger(0, forKey: "score")
            defaults.setValue(userNameTextField.text!, forKey: "user_name")
        }
    }
   /* private func setUpDatabase(user_name user: String, email: String, password: String) {
        
    }*/
    // MARK: - Alert
    func alertOccure(text: String) {
        let alert = UIAlertController(title: "Oops", message: text, preferredStyle: .Alert)
        let ok_button = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok_button)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}