//
//  RoundedView.swift
//  PianoMemory
//
//  Created by Wojciech Karaś on 06/01/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    override func awakeFromNib() {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
