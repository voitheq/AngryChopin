//
//  Settings.swift
//  AngryChopin
//
//  Created by Wojciech Karaś on 18/01/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import UIKit


let highscoreKey = "highscore"

enum Info: String {
    case tapToPlay = "TAP TO PLAY"
    case memorize = "MEMORIZE"
    case playMelody = "PLAY MELODY"
    case gameOver = "GAME OVER"
}

enum LabelText: String {
    case score = "SCORE: "
    case highscore = "HIGHSCORE: "
}

let black = UIColor.black

enum AnimTime: Double {
    case userTapped = 0.1
    case showKey = 0.7
}

let radius: CGFloat = 8.0
