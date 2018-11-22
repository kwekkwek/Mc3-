//
//  MainSceneViewController.swift
//  Mc3plus_SpeechText
//
//  Created by Benny Kurniawan on 21/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit
import AVFoundation

class Scene2_ViewController: UIViewController {
    
    //MARK: Variables
    var swipeRight:UISwipeGestureRecognizer?
    var doubleTap: UITapGestureRecognizer?
    var sound: AVAudioPlayer?
    var speechText: AVSpeechSynthesizer?
    
    let textNarration = ""
    
    let textInstruction = "Swipe right."
    
    //MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        soundsInit()
        speechText = AVSpeechSynthesizer()
        speechText?.delegate = self
        
        DispatchQueue.global().async {
            self.speech(x: self.textInstruction)
        }
        
    }
    
    //MARK: Function
    
    //MARK: Gesture Function
    func swipethisRight() {
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(Handler))
        swipeRight?.direction = .right
        guard let swipeRight = swipeRight else {return}
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc func Handler() {
        sound?.play()
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
        let soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "footstep", ofType: "wav")!)
        
        do {
            try sound = AVAudioPlayer(contentsOf: soundURL)
            sound?.delegate = self
            sound?.prepareToPlay()
        }
        catch {
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
extension Scene2_ViewController:AVSpeechSynthesizerDelegate
{
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("kata dimulai")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finish")
        swipethisRight()
        replayInstruction()
    }
}
extension Scene2_ViewController: AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finish SFX")
        let destination = Scene3_ViewController()
        navigationController?.pushViewController(destination, animated: false)
    }
}
