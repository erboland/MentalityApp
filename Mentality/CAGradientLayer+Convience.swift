//
//  CAGradientLayer+Convience.swift
//  Mentality
//
//  Created by user on 7/28/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    func turquoiseColor() -> CAGradientLayer {
        let bottomColor = UIColor(red: (0/255), green: (198/255), blue: (255/255), alpha: 1)
        let topColor = UIColor(red: 0/255, green: 114/255, blue: 255/255, alpha: 1)
        let gradientColors : [CGColor] = [topColor.CGColor,  bottomColor.CGColor]
        let gradientLocations :[Float] = [0.0, 1.0]
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        return gradientLayer
    }
}
