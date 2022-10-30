//
//  UIButton_extension.swift
//  nadumkin@edu.hse.ru PW 3
//
//  Created by Никита Думкин on 29.09.2022.
//

import UIKit

extension UIButton{
    func CALayerShadow(
        width: Double,
        height: Double,
        color: CGColor,
        shadowOpacity: Float = 0.1,
        shadowRadius: CGFloat = 5
    )
    {
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowColor = color
    }
}
