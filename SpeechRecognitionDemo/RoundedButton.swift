//
//  RoundedButton.swift
//  SpeechRecognitionDemo
//
//  Created by Upendar Gareri on 27/10/2016.
//  Copyright © 2016 Upendar Gareri. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            designUI()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        designUI()
    }
    
    func designUI() {
        layer.cornerRadius = cornerRadius
    }

}
