//
//  LessonsViewController.swift
//  Mentality
//
//  Created by Ербол Каршыга on 7/25/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//


import UIKit
import KDCircularProgress
import Cartography

class LessonsViewController: UIViewController {
    
    @IBOutlet var buttons: [ButtonsView]!

     var fileName = String()
  
   lazy var defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let background = CAGradientLayer().turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        self.tabBarController?.tabBar.barStyle = .Black
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()

        let progress = KDCircularProgress(frame: CGRect(x: 10, y: 35, width: 180, height: 180))
        progress.startAngle = -90
        progress.progressThickness = 0.25
        progress.trackThickness = 0.5
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .NoGlow
        progress.angle = 360*((Double(lastLevelNumber)) / 10)
        progress.trackColor = UIColor.whiteColor()
        progress.setColors(UIColor.blueColor())
        progress.animateToAngle(progress.angle, duration: 0.5, completion: nil)
        view.addSubview(progress)

        setUpViews()
        setUpConstraints()
        animateButtons(initial_state: CGAffineTransformMakeScale(0.0001, 0.0001), final_state: CGAffineTransformIdentity)
        
        let progressLabel = UILabel(frame: CGRect(x: 80, y: 80, width: 100, height: 100))
        progressLabel.text = "\((lastLevelNumber)*10)%"
        progressLabel.adjustsFontSizeToFitWidth = true
        progressLabel.backgroundColor = UIColor.clearColor()
        progressLabel.textColor = UIColor.whiteColor()
        view.addSubview(progressLabel)
        progressLabel.center = progress.center
        progressLabel.textAlignment = .Center
        progressLabel.font = UIFont(name: "Helvetica", size: 30)
        
        let infoLabel = UILabel(frame: CGRect(x: 190, y: 55, width: 130, height: 100))
        infoLabel.text = "Of all practice is done"
        infoLabel.numberOfLines = 5
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.backgroundColor = UIColor.clearColor()
        infoLabel.textColor = UIColor.whiteColor()
        infoLabel.textAlignment = .Center
        infoLabel.font = UIFont (name: "Helvetica", size: 30)
        view.addSubview(infoLabel)
        constrain(infoLabel) { infoLabel in
            infoLabel.leftMargin
            infoLabel.left
        
        }
        }
    
    
    private func setUpViews() {
        buttons
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func setUpConstraints() {
        buttons
            .sortInPlace { $0.0.tag < $0.1.tag }
        [
            NSLayoutConstraint(item: buttons[0], attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: buttons[1], attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: buttons[2], attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: buttons[3], attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: -20),
            ].forEach {$0.active = true}
    }
    
    //MARK:- animation
    private func animateButtons(initial_state a: CGAffineTransform, final_state b: CGAffineTransform) {
        buttons
            .sort { $0.0.tag < $0.1.tag }
            .enumerate()
            .forEach { idx, button in
                button.transform = a
                UIView.animateWithDuration(1.0, delay: Double(idx) * 0.25,
                    usingSpringWithDamping: 0.40,
                    initialSpringVelocity: 4.00,
                    options: UIViewAnimationOptions.AllowUserInteraction,
                    animations: {
                        button.transform = b
                }, completion: nil)
                button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        }
    }
    
    func buttonAction(sender: UIButton) {
        animateButtons(initial_state: CGAffineTransformIdentity, final_state: CGAffineTransformMakeScale(0.0001, 0.0001))
        let delay: Int64 = 2
       switch sender.tag {
        case 1:
            print("Plus button")
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), delay * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
            self.fileName = "addition"
             self.performSegueWithIdentifier("KolodaVC", sender: nil)
              }
        case 2:
            print("Minus button")
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), delay * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.fileName = "substraction"
                self.performSegueWithIdentifier("KolodaVC", sender: nil)
             }
        case 3:
            print("Multiply button")
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), delay * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.fileName = "multiplication"
                self.performSegueWithIdentifier("KolodaVC", sender: nil)
          }
        case 4:
            print("Divide button")
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), delay * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.fileName = "division"
                self.performSegueWithIdentifier("KolodaVC", sender: nil)
               }
       default:
            break
        }
        
    }

    //MARK:- draggableViews
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
            let kolodaVC = segue.destinationViewController as! KolodaViewController
        print(fileName)
            kolodaVC.fileName = fileName
            
    }
    
}



