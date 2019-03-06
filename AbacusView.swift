//
//  AbacusView.swift
//  Mentality
//
//  Created by Ербол Каршыга on 8/2/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit

class AbacusView: UIView {
    lazy var images: [Int:UIImageView] = [:]
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViews()
        loadConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- settings
    func loadViews() {
        for i in 0..<6 {
            for low in 0..<4 {
                let bottom_image = UIImageView()
                bottom_image.frame.size.width = self.frame.size.width
                bottom_image.tag = (i == 0 ? (low+1) : low + 1 + Int(pow(10.0,Double(i))))
                images[bottom_image.tag] = bottom_image
            }
            let high_image = UIImageView()
            high_image.tag = (i == 0 ? 5 : 5 + Int(pow(10.0,Double(i))))
            images[high_image.tag] = high_image
        }
        for each in images.values {
            //prepare for layout
            each.translatesAutoresizingMaskIntoConstraints = false
            //ading swipe recognizer
            let directions:[UISwipeGestureRecognizerDirection] = [.Up, .Down]
            for direction in directions {
                let swipe_gesture_recognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
                swipe_gesture_recognizer.direction = direction
                each.addGestureRecognizer(swipe_gesture_recognizer)
            }
        }
    }
    func loadConstraints() {
        NSLayoutConstraint(item: self.viewWithTag(100001)!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .LeftMargin, multiplier: 1, constant: 20).active = true
        for low in 0..<6 {
            let index = (low == 0 ? 1 : 1 + Int(pow(10.0,Double(low))) )
            NSLayoutConstraint(item: self.viewWithTag(index)!, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 20).active = true
        }
        
    }
    //MARK:- swipeGestureRecognizer
    func swipeGesture() {
        
    }
}
