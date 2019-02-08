//
//  PianoPlayer.swift
//  AngryChopin
//
//  Created by Wojciech Karaś on 18/01/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import AVFoundation

class PianoPlayer {
    
    private var audioPlayers = [Int : AVAudioPlayer]()
    
    func playNote(note: Int) {
        if let audioPlayer = audioPlayers[note] {
            if audioPlayer.isPlaying{
                audioPlayer.currentTime = 0
            }else{
                audioPlayer.play()
            }
        }else{
            if let soundURL = Bundle.main.url(forResource: "sound\(note)", withExtension: "wav") {
                do{
                    let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayers[note] = audioPlayer
                    audioPlayer.play()
                }catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
