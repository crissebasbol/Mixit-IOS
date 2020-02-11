//
//  DesignableView.swift
//  Mixit
//
//  Created by Cristhian Bolaños on 2/11/20.
//  Copyright © 2020 Cristhian Bolaños. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView{
    //the flags IBInspectable allow to edit these properties inside of storyboard for any view that is a desirableView
    @IBInspectable var shadowColor: UIColor = UIColor.clear{
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0{
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowOpacity: CGFloat = 0{
        didSet{
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    @IBInspectable var shadowOffsetY: CGFloat = 0{
        didSet{
            layer.shadowOffset.height = shadowOffsetY
        }
    }
}
