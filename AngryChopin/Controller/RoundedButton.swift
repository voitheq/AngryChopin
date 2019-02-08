//
//  RoundedButton.swift
//  PianoMemory
//
//  Created by Wojciech Karaś on 06/01/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    var oryginalBackgroundColor: UIColor?
    
    override func awakeFromNib() {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        
        oryginalBackgroundColor = backgroundColor
    }
}
