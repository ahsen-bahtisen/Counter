//
//  GameOverViewController.swift
//  Counter
//
//  Created by Gokberk Ozcan on 13.11.2022.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var scoreTableView: UITableView!
    
    var newScore: Int = 0
    var scoreArray: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        yourScoreLabel.text = ("\(newScore)")
        scoreArray = (UserDefaults.standard.array(forKey: "scoreArray") as? [Int])!
        scoreArray.sort {
            $0 > $1
        }
        scoreTableView.delegate = self
        scoreTableView.dataSource = self

        print(scoreArray)
    }
    
}

extension GameOverViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scoreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        cell.textLabel?.text = String(scoreArray[indexPath.row])
        return cell
    }
    
    
}
