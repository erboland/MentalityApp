//
//  ResulViewController.swift
//  Mentality
//
//  Created by Ербол Каршыга on 8/1/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit
 


class ResulViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    var documentController : UIDocumentInteractionController!
    @IBOutlet weak var scoreLabel: UILabel!
    var score :Int!
    var highestScore = [0]
    let defaults = NSUserDefaults.standardUserDefaults()
    var level: Int!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (level)
        let lastLevel = defaults.integerForKey("score") 
        if let gettingArray = defaults.objectForKey("\(level)") as? [Int] {
            highestScore = gettingArray
            }
        var gScore  = defaults.integerForKey("score")
        
        // Do any additional setup after loading the view.
        
        if score > highestScore.maxElement() {
            highestScore.append(score)
            highestScore.removeFirst()
        }
        let background = CAGradientLayer().turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        scoreLabel.text = "Your score is \n\(score) \nThe best score is \n\(highestScore.maxElement()!)"
        defaults.setObject(highestScore, forKey: "\(level)")
        if lastLevel == level-1 {
        if score >= 25 {
            alertController("Level up!", message: "You opened \(lastLevel+1)")
            gScore += 1
            defaults.setInteger(gScore, forKey: "score")
            
            }
        }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
                
    
    
    @IBAction func shareButtonPressed(sender: UIButton) {
        let messageStr:String  = "I earned \(score) points in new \"Mentality!\" app. Check out in the App Store!"
        let img: UIImage = screenShotMethod()
        //var shareItems:Array = [img, messageStr]
        let shareItems:Array = [img, messageStr]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
   
    func screenShotMethod()-> UIImage {
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    func alertController (title:String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    @IBAction func nextLevelPressed(sender: UIButton) {
        if lastLevelNumber > level {
            performSegueWithIdentifier("nextLevelSegue", sender: nil)
        } else {
            alertController("Oops!", message: "You still didn't open next level")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nextLevelSegue" {
            
            let destVC = segue.destinationViewController as! GameViewController
            destVC.level = level + 1
        }
    }
}
