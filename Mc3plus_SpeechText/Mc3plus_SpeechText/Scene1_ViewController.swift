//
//  Scene1_ViewController.swift
//  Mc3plus_SpeechText
//
//  Created by Benny Kurniawan on 21/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit
import AVFoundation

class Scene1_ViewController: UIViewController {
    
    //MARK : Variable native lib
    var swipeUp: UISwipeGestureRecognizer?
    var sound: AVAudioPlayer?
    var speechText: AVSpeechSynthesizer?
    
    //MARK : Variable
    let textSpeech:String = "Good. Now , swipe up"
    
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
    func needswipeUp()
    {
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(thisHandler))
        swipeUp?.direction = .up
        guard let swipeUp = swipeUp else {return}
        view.addGestureRecognizer(swipeUp)
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
extension Scene1_ViewController: AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        let dest = Scene2_ViewController()
        navigationController?.pushViewController(dest, animated: false)
    }
    
}
extension Scene1_ViewController: AVSpeechSynthesizerDelegate
{
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        needswipeUp()
    }
}
