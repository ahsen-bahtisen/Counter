//
//  ViewController.swift
//  Counter
//
//  Created by Ahsen Bahtışen on 13.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet var highScoreLabel: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    
    var counter: Int = 15
    var score: Int = 0
    var highScore: Int = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.setTitle("Start", for: .normal)
        timeLeftLabel.text = ("\(counter)")
        scoreButton.isHidden = true

    }
    
    @IBAction func startButton(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        startButton.isHidden = true
        scoreButton.isHidden = false
    }
    
    @IBAction func scoreButton(_ sender: Any) {
        score += 1
        scoreButton.setTitle("\(score)", for: .normal)
        
    }
    
    @objc func timerFunction(){
        timeLeftLabel.text = "Time: \(counter)"
        counter -= 1
        
        if counter == -1 {
            timeLeftLabel.text = "Time's Over."
            if self.score > self.highScore {
                self.highScore = self.score
//                UserDefaults.standard.set(self.highScore, forKey: "highscore")
                
            }
        }
    }
}
