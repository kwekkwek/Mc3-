//
//  Scene3_ViewController.swift
//  Mc3plus_SpeechText
//
//  Created by Benny Kurniawan on 21/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit
import AVFoundation
class Scene3_ViewController: UIViewController {

    
    //MARK: Variables
    var swipeUp:UISwipeGestureRecognizer?
    var doubleTap: UITapGestureRecognizer?
    var sound: AVAudioPlayer?
    var speechText: AVSpeechSynthesizer?
    let textNaration = " "
    let textInstruction = "Go straight to the find the work table by swiping up"
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
    func swipethisUp() {
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(Handler))
        swipeUp?.direction = .up
        guard let swipeUp  = swipeUp else {return}
        view.addGestureRecognizer(swipeUp)
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
        speecUtterance.preUtteranceDelay = 1
        speecUtterance.postUtteranceDelay = 1
        
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
extension Scene3_ViewController:AVSpeechSynthesizerDelegate
{
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("kata dimulai")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finish")
        swipethisUp()
        replayInstruction()
    }
}
extension Scene3_ViewController: AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finish SFX")
        let destination = Scene4_ViewController()
        navigationController?.pushViewController(destination, animated: false)
    }
}
