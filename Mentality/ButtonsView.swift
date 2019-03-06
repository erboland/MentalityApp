//
//  PlusButtonView.swift
//  Mentality
//
//  Created by user on 7/28/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit
@IBDesignable
class ButtonsView: UIButton {
    @IBInspectable var fillColor: UIColor = UIColor(red: 220/255, green: 36/255, blue: 65/255, alpha: 1)
    @IBInspectable var isAddButton: Bool = true
    @IBInspectable var isMinusButton: Bool = true
    @IBInspectable var isDivideButton: Bool = true
    @IBInspectable var isMultiplyButton: Bool = true
    override func drawRect(rect: CGRect) {
        //circle
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        //pluse sign
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        //create the path
        let plusPath = UIBezierPath()
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        //move to othe point
        if isMinusButton {
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        }
        if isAddButton {
            plusPath.moveToPoint(CGPoint(
                x:bounds.height/2 + 0.5,
                y:bounds.width/2 - plusWidth/2 + 0.5))
            //add a point to the path at the end of the stroke
            plusPath.addLineToPoint(CGPoint(
                x:bounds.height/2 + 0.5,
                y:bounds.width/2 + plusWidth/2 + 0.5))
        }
        if isDivideButton {
            let radius: CGFloat = max(bounds.width, bounds.height) * 0.10
            let circlePathOne = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2,y: bounds.height/2 - 15), radius: CGFloat(radius/2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePathOne.CGPath
            shapeLayer.fillColor = UIColor.whiteColor().CGColor
            shapeLayer.strokeColor = UIColor.whiteColor().CGColor
            shapeLayer.lineWidth = 3
            let circlePathTwo = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2,y: bounds.height/2 + 15), radius: CGFloat(radius/2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            let shapeLayerTwo = CAShapeLayer()
            shapeLayerTwo.path = circlePathTwo.CGPath
            shapeLayerTwo.fillColor = UIColor.whiteColor().CGColor
            shapeLayerTwo.strokeColor = UIColor.whiteColor().CGColor
            shapeLayerTwo.lineWidth = 3
            layer.addSublayer(shapeLayerTwo)
            layer.addSublayer(shapeLayer)
        }
        if isMultiplyButton {
            plusPath.moveToPoint(CGPoint(
                x:bounds.width/2 - plusWidth/2 * 0.7 + 0.5,
                y: bounds.height/2 * 0.35 + 0.5))
            //add a point to the path at the end of the stroke
            plusPath.addLineToPoint(CGPoint(
                x:bounds.width/2 + plusWidth/2 * 0.7 + 0.5,
                y:bounds.height/2 * 1.65 + 0.5))
            plusPath.moveToPoint(CGPoint(
                x:bounds.width/2 + plusWidth/2 * 0.7 + 0.5,
                y: bounds.height/2 * 0.35 + 0.5))
            //add a point to the path at the end of the stroke
            plusPath.addLineToPoint(CGPoint(
                x:bounds.width/2 - plusWidth/2 * 0.7 + 0.5,
                y:bounds.height/2 * 1.65 + 0.5))
        }
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }
}
