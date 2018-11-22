//
//  MainSceneViewController.swift
//  Mc3plus_SpeechText
//
//  Created by Benny Kurniawan on 21/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit
import AVFoundation

class MainSceneViewController: UIViewController {
    
    //MARK: Variables
    var swipeDown:UISwipeGestureRecognizer?
    var doubleTap: UITapGestureRecognizer?
    var sound: AVAudioPlayer?
    var doorSound: AVAudioPlayer?
    var speechText: AVSpeechSynthesizer?
    let textNarration = "Welcome to Black Out, where your auditory is challenged. Please listen carefully and follow all the given instructions to finish the task. Just remember, seeing is not everything."
    
    let textInstruction = "This is your first task, find a flashlight for your brother. It is located at the study room. Now, swipe down to open your door. You can tap thrice to repeat this instruction"
    
    //MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        soundsInit()
        speechText = AVSpeechSynthesizer()
        speechText?.delegate = self
        
        DispatchQueue.global().async {
            self.speech(x: self.textNarration)
            self.speech(x: self.textInstruction)
        }
        
    }

//MARK: Function
    
    //MARK: Gesture Function
    func swipethisDown() {
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(Handler))
        swipeDown?.direction = .down
        guard let swipeDown = swipeDown else {return}
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func Handler() {
        sound?.play()
        doorSound?.play()
    }
    
    func replayInstruction() {
        doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap?.numberOfTapsRequired = 3
        guard let doubleTap = doubleTap else {return}
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func doubleTapped() {
        speech(x: textInstruction)
    }
    
    //MARK: Sounds Function
    func soundsInit() {
        let soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "My Movie", ofType: "wav")!)
        
        do {
            try sound = AVAudioPlayer(contentsOf: soundURL)
            sound?.delegate = self
            sound?.prepareToPlay()
        }
        catch {
            print("error: \(error.localizedDescription)")
        }
        
        let doorOpenURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "door_open", ofType: "wav")!)
        
        do {
            try doorSound = AVAudioPlayer(contentsOf: doorOpenURL)
            doorSound?.delegate = self
            doorSound?.prepareToPlay()
            
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    //MARK: Speech Function
    func speech(x: String) {
        
        let speecUtterance = AVSpeechUtterance(string: x)
        speecUtterance.voice = AVSpeechSynthesisVoice (language: "ind-INA")
        speecUtterance.rate = 0.5
        speecUtterance.pitchMultiplier = 1
        speecUtterance.preUtteranceDelay = 0
        speecUtterance.postUtteranceDelay = 0.003

        speechText?.speak(speecUtterance)
        
    }
    
    //MARK: show and hide navigation controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
extension MainSceneViewController:AVSpeechSynthesizerDelegate
{
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("kata dimulai")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finish")
        swipethisDown()
        replayInstruction()
    }
}
extension MainSceneViewController: AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finish SFX")
        let destination = Scene1_ViewController()
        navigationController?.pushViewController(destination, animated: false)
    }
}
