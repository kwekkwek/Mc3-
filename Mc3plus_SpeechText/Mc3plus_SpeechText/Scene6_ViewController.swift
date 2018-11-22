//
//  Scene6_ViewController.swift
//  Mc3plus_SpeechText
//
//  Created by Yuvens Putra Barata on 22/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit
import AVFoundation
class Scene6_ViewController: UIViewController {
    
    //MARK: Variables
    var tapGesture:UITapGestureRecognizer?
    var doubleTap: UITapGestureRecognizer?
    var sound: AVAudioPlayer?
    var speechText: AVSpeechSynthesizer?
    let textNaration = "Great!, You’ve find the flashlight! "
    let textInstruction = "Double tap to turn it on "
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        soundsInit()
        speechText = AVSpeechSynthesizer()
        speechText?.delegate = self
        
        DispatchQueue.global().async {
            self.speech(x: self.textInstruction)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Gesture Function
    func TapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(Handler))
        tapGesture?.numberOfTapsRequired = 2
        guard let tapGesture  = tapGesture else {return}
        view.addGestureRecognizer(tapGesture)
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
        let soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "My Movie", ofType: "wav")!)
        
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
        speecUtterance.voice = AVSpeechSynthesisVoice (language: "ina-INA")
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
extension Scene6_ViewController:AVSpeechSynthesizerDelegate
{
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("kata dimulai")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finish")
        TapGesture()
        replayInstruction()
    }
}
extension Scene6_ViewController: AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finish SFX")
        navigationController?.popToRootViewController(animated: false)
    }
}

