//
//  MainSceneViewController.swift
//  Mc3plus_SpeechText
//
//  Created by Benny Kurniawan on 21/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit
import AVFoundation

class MainSceneViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    //MARK: Variables
    var swipeDown:UISwipeGestureRecognizer?
    var sound: AVAudioPlayer?
    let textNarration = "Welcome to Black Out, where your auditory is challenged. Please listen carefully and follow all the given instructions to finish the task. Just remember, seeing is not everything."
    
    let textInstruction = "This is your first task, find a flashlight for your brother. It is located at the study room. Now, swipe down to open your door."
    
    //MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        soundsInit()
        speech(x: textNarration + textInstruction)
        swipethisDown()
    }
    
//MARK: Function
    
    //MARK: Gesture Function
    func swipethisDown() {
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(Handler))
        swipeDown?.direction = .down
        guard let swipeDown = swipeDown else {return}
        view.addGestureRecognizer(swipeDown)
    }
    @objc func Handler()
    {
        sound?.play()
    }
    
    //MARK: Sounds Function
    func soundsInit() {
        let soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "My Movie", ofType: "wav")!)
        
        do {
            try sound = AVAudioPlayer(contentsOf: soundURL)
            sound?.prepareToPlay()
        }
        catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    //MARK: Speech Function
    func speech(x: String) {
        let speechText = AVSpeechUtterance(string: x)
        
        speechText.voice = AVSpeechSynthesisVoice (language: "ind-INA")
        speechText.rate = 0.5
        speechText.pitchMultiplier = 1
        speechText.preUtteranceDelay = 0
        
        let speaker = AVSpeechSynthesizer()
        speaker.speak(speechText)
        speechText.postUtteranceDelay = 0.003
    }

}
