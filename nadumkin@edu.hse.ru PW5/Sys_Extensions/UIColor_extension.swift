//
//  UIColor_extension.swift
//  nadumkin@edu.hse.ru PW 3
//
//  Created by Никита Думкин on 30.09.2022.
//

import UIKit

extension UIColor{
    
    
    var redComponent: CGFloat{
        get{
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return red;
        }
    }
    
    var greenComponent: CGFloat{
        get{
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return green;
        }
    }
    
    var blueComponent: CGFloat{
        get{
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return blue;
        }
    }
    
    var alphaComponent: CGFloat{
        get{
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return alpha;
        }
    }
}
