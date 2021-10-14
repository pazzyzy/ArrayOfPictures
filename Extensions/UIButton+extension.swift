//
//  view+extantions.swift
//  07.10
//
//  Created by Ant Zy on 07.10.2021.
//

import UIKit

extension UIButton {
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.8
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
    
    func addGradientWithColor(color: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
//        gradient.cornerRadius = frame.height / 2
        gradient.colors = [UIColor.clear.cgColor, color.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
    func corner() {
        layer.cornerRadius = frame.height / 2
        layer.sublayers?.forEach { $0.cornerRadius = frame.height / 2 }
    }
}
