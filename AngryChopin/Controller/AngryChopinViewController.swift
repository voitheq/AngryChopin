//
//  ViewController.swift
//  PianoMemory
//
//  Created by Wojciech Karaś on 05/01/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import UIKit
import AVFoundation

class AngryChopinViewController: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet var keys: [RoundedButton]!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    //MARK: - VARIABLES
    private var score = 0 {
        didSet {
            scoreLabel.text = LabelText.score.rawValue + "\(score)"
        }
    }
    private var highscore = 0 {
        didSet {
            highscoreLabel.text = LabelText.highscore.rawValue + "\(highscore)"
        }
    }
    
    private var melody = [Int]()
    private var note = 0
    
    private let pianoPlayer = PianoPlayer()
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    //MARK: - VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highscore = UserDefaults.standard.integer(forKey: highscoreKey)
        
        keys = keys.sorted(){
            $0.tag < $1.tag
        }
        setKeysIsEnabled(to: false)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        
        infoLabel.text = Info.tapToPlay.rawValue
    }
    
    @objc private func viewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else {
            return
        }
        if gestureRecognizer.state == .ended {
            startGame()
        }
    }
    
    private func setKeysIsEnabled(to isEnabled:Bool){
        for key in keys{
            key.isEnabled = isEnabled
        }
    }
    
    private func startGame(){
        view.removeGestureRecognizer(tapGestureRecognizer)
        self.infoLabel.text = Info.memorize.rawValue
        score = 0
        melody.removeAll()
        nextStep()
    }
    
    private func nextStep() {
        note = 0
        addNote()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.infoLabel.text = Info.memorize.rawValue
            self.playMelody()
        }
    }
    
    private func addNote() {
        melody.append(Int.random(in: 0...12))
    }
    
    private func playMelody(){
        if note < melody.count{
            showKey(for: melody[note], action: playMelody)
            pianoPlayer.playNote(note: melody[note])
            note += 1
        }else{
            note = 0
            infoLabel.text = Info.playMelody.rawValue
            setKeysIsEnabled(to: true)
        }
    }
    
    private func showKey(for note: Int, action: (() -> Void)?) {
        let key = keys[note]
        UIView.animate(withDuration: AnimTime.showKey.rawValue, animations: {
            key.backgroundColor = black
            key.backgroundColor = key.oryginalBackgroundColor
        }) { finished in
            if let action = action{
                action()
            }
        }
    }
    
    @IBAction func keyTouchDown(_ sender: RoundedButton) {
        UIView.animate(withDuration: AnimTime.userTapped.rawValue) {
            sender.backgroundColor = black
        }
        pianoPlayer.playNote(note: sender.tag - 1)
        if sender.tag - 1 == melody[note] {
            score += 1
            note += 1
            if note == melody.count {
                setKeysIsEnabled(to: false)
                nextStep()
            }
        }else{
            if score > highscore{
                highscore = score
                UserDefaults.standard.set(highscore, forKey: highscoreKey)
            }
            setKeysIsEnabled(to: false)
            pianoPlayer.playNote(note: melody[note])
            showKey(for: melody[note], action: nil)
            infoLabel.text = Info.gameOver.rawValue
            view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBAction func keyTouchUpInside(_ sender: RoundedButton) {
        UIView.animate(withDuration: AnimTime.userTapped.rawValue) {
            sender.backgroundColor = sender.oryginalBackgroundColor
        }
    }
    
    @IBAction func keyTouchUpOutside(_ sender: RoundedButton) {
        UIView.animate(withDuration: AnimTime.userTapped.rawValue) {
            sender.backgroundColor = sender.oryginalBackgroundColor
        }
    }
}
