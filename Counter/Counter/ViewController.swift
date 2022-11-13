//
//  ViewController.swift
//  Counter
//
//  Created by Ahsen Bahtışen on 13.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var counter: Int = 3
    var score: Int = 0
    var highScore: Int = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.setTitle("Start", for: .normal)
        timeLeftLabel.text = ("\(counter)")
        scoreButton.isHidden = true
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScoreLabel.text = "Highscore: 0"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
    }

    @IBAction func startButton(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        startButton.isHidden = true
        scoreButton.isHidden = false
        scoreButton.setTitle("\(score)", for: .normal)
    }
    
    @IBAction func scoreButton(_ sender: Any) {
        score += 1
        scoreButton.setTitle("\(score)", for: .normal)
        
    }
    
    @objc func timerFunction(){
        timeLeftLabel.text = "Time: \(counter)"
        counter -= 1
        
        if counter == -1 {
            timer.invalidate()
            timeLeftLabel.text = "Time's Over."
            if self.score > self.highScore {
                self.highScore = self.score
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            var scoreArray = UserDefaults.standard.array(forKey: "scoreArray")
            if scoreArray == nil {
                let scoreArr: [Int] = [score]
                UserDefaults.standard.set(scoreArr, forKey: "scoreArray")
            } else {
                scoreArray?.append(score)
                UserDefaults.standard.set(scoreArray, forKey: "scoreArray")
            }
            
            performSegue(withIdentifier: "gameOverViewController", sender: self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOverViewController" {
            if let viewController = segue.destination as? GameOverViewController {
                if score != nil {
                    viewController.newScore = score
                }
            }
        }
    }
}
