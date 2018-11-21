//
//  MainSceneViewController.swift
//  Mc3plus_SpeechText
//
//  Created by Benny Kurniawan on 21/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController {
    var swipeDown:UISwipeGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        swipethisDown()
    }
    func swipethisDown() {
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(Handler))
        swipeDown?.direction = .down
        guard let swipeDown = swipeDown else {return}
        view.addGestureRecognizer(swipeDown)
    }
    @objc func Handler()
    {
        print("swipe")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
