//
//  MulitplayerViewController.swift
//  Mentality
//
//  Created by Ербол Каршыга on 8/9/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit

class MulitplayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let background = CAGradientLayer().turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)

        // Do any additional setup after loading the view.
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
