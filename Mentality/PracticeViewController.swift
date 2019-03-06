//
//  PracticeViewController.swift
//  Mentality
//
//  Created by Ербол Каршыга on 7/25/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit
var lastLevelNumber = NSUserDefaults.standardUserDefaults().integerForKey("score")

class PracticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewLessons: UITableView!
    lazy var defaults = NSUserDefaults.standardUserDefaults()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score = defaults.integerForKey("score")
        print (score)
        
        let background = CAGradientLayer().turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        self.tabBarController?.tabBar.barStyle = .Black
        
        tableViewLessons.delegate = self
        tableViewLessons.dataSource = self
        tableViewLessons.contentOffset = CGPointMake(0, CGFloat.min)
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = Int()
        switch section {
         case 0:
            rows = 1
        case 1:
            rows = 10
        default:
            print("error in rows")
        }
        return rows
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = CustomCellTableViewCell()
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("cellWithCloud", forIndexPath: indexPath) as! CustomCellTableViewCell
            return cell
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("cellWithLevel", forIndexPath: indexPath) as! CustomCellTableViewCell
            if (9 - indexPath.row) > score {
                cell.userInteractionEnabled = true
                cell.shapeLayer.fillColor = UIColor(red: 25/255, green: 25/255, blue: 112/255, alpha: 1).CGColor
                cell.layer.masksToBounds = true
                } else {
                cell.userInteractionEnabled = true
                cell.shapeLayer.fillColor = UIColor(red: 0/255, green: 178/255, blue: 238/255, alpha: 1).CGColor
                cell.layer.masksToBounds = true
            }
            cell.label.text = String(10 - indexPath.row)
            return cell
        default:
            break
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (9 - indexPath.row) <= score {
        performSegueWithIdentifier("levelSegue", sender: nil)
        } else {
            let alertController = UIAlertController(title: "Unable to practice", message:
                "You should score 25 points to open next level", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "levelSegue" {
            if let indexPath = tableViewLessons.indexPathForSelectedRow {
                let destVC = segue.destinationViewController as! GameViewController
                destVC.level = 10 - indexPath.row
            }
    }
    }
    
}

extension PracticeViewController {
    
    func enable(num: Int) {
        if let cell = tableViewLessons.cellForRowAtIndexPath(NSIndexPath(forRow: num, inSection: 0)){
        
                cell.userInteractionEnabled = true
        }

    }
}
