//
//  Scene4_ViewController.swift
//  Mc3plus_SpeechText
//
//  Created by Yuvens Putra Barata on 22/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit
import AVFoundation

class Scene4_ViewController: UIViewController {
    
    //MARK : Variable native lib
    var swipeDown: UISwipeGestureRecognizer?
    var sound: AVAudioPlayer?
    var speechText: AVSpeechSynthesizer?
    
    //MARK : Variable
    let textSpeech:String = "Now, investigate the drawers in front of you, swipe down to investigate"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK : View
        view.backgroundColor = .black
        //MARK : variable
        speechText = AVSpeechSynthesizer()
        speechText?.delegate = self
        soundsInit()
        toSpeechText(text: textSpeech)
        // Do any additional setup after loading the view.
    }
    func needswipeDown()
    {
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(thisHandler))
        swipeDown?.direction = .down
        guard let swipeDown = swipeDown else {return}
        view.addGestureRecognizer(swipeDown)
    }
    @objc func thisHandler()
    {
        sound?.play()
    }
    func toSpeechText(text: String)
    {
        let speecUtterance = AVSpeechUtterance(string: text)
        speecUtterance.voice = AVSpeechSynthesisVoice (language: "ind-INA")
        speecUtterance.rate = 0.5
        speecUtterance.pitchMultiplier = 1
        speecUtterance.preUtteranceDelay = 0
        speecUtterance.postUtteranceDelay = 0.003
        
        speechText?.speak(speecUtterance)
    }
    func soundsInit() {
        let soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "drawer", ofType: "wav")!)
        
        do {
            try sound = AVAudioPlayer(contentsOf: soundURL)
            sound?.delegate = self
            sound?.prepareToPlay()
        }
        catch {
            print("error: \(error.localizedDescription)")
        }
    }
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
extension Scene4_ViewController: AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        let dest = Scene5_ViewController()
        navigationController?.pushViewController(dest, animated: false)
    }
    
}
extension Scene4_ViewController: AVSpeechSynthesizerDelegate
{
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        needswipeDown()
    }
}

