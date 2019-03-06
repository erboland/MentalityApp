//
//  CGDraggableView.swift
//  Mentality
//
//  Created by Ербол Каршыга on 7/30/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit

protocol SendNumberDelegate {
    func sendNumber(num: Float)
}

var viewNumber = 0

class CGDraggableView: UIView {
    
    var original_point = CGPoint()
    var del: SendNumberDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        self.layer.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).CGColor
        self.layer.masksToBounds = true
        let pan_gesture_recognizer = UIPanGestureRecognizer(target: self, action: #selector(self.dragged))
                self.addGestureRecognizer(pan_gesture_recognizer)
        loadStyle()
        self.alpha = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadStyle() {
        self.layer.cornerRadius = 8
    }
    func dragged(gesture_recognizer recognizer: UIPanGestureRecognizer) {
        let xDistance: CGFloat = recognizer.translationInView(self).x
       
        switch recognizer.state {
        case .Began:
            self.original_point = self.center
        case .Changed:
            let rotationStrength: CGFloat = min(xDistance / 320, 1)
            let rotationAngel: CGFloat = min(CGFloat((2 * M_PI * Double(rotationStrength) / 16)), CGFloat(M_PI_4))
            let scaleStrength: CGFloat = 1 - CGFloat(fabsf(Float(rotationStrength))) / 4
            let scale: CGFloat = max(scaleStrength, 0.93)
            self.center = CGPointMake(self.original_point.x + xDistance, self.original_point.y)
            let transform: CGAffineTransform = CGAffineTransformMakeRotation(rotationAngel)
            let scaleTransform: CGAffineTransform = CGAffineTransformScale(transform, scale, scale)
            self.transform = scaleTransform
            self.alpha = self.alpha - CGFloat(abs(xDistance)/(abs(xDistance) + 1000))
            
        case .Ended:
            if abs(xDistance) >= 80 {
                viewNumber += 1
                del.sendNumber(Float(viewNumber))
                print(viewNumber,"lego")
                self.removeFromSuperview()
            } else {
               self.resetViewPositionAndTransformations()
            }
        case .Possible:
            break
        case .Cancelled:
            break
        case .Failed:
            break
        }
        
    }
    
    func resetViewPositionAndTransformations() {
        UIView.animateWithDuration(0.4, animations: {() -> Void in
            self.center = self.original_point
            self.transform = CGAffineTransformMakeRotation(0)
            self.alpha = 1
        })
    }
}
