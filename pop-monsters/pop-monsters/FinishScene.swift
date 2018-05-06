//
//  FinishScene.swift
//  pop-monsters
//
//  Created by Samaneh Fathieh on 6/5/18.
//  Copyright © 2018 Samaneh Fathieh. All rights reserved.
//

import SpriteKit

// Struct to hold each players record
struct ScoreRecord: Codable {
    let playerName: String
    let score: Double
    init(playerName: String, score: Double) {
        self.playerName = playerName
        self.score = score
    }
}

// Custom Table view to show top users scores
class GameRoomTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    var items: [ScoreRecord] = []
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = "\(self.items[indexPath.row].score) - \(self.items[indexPath.row].playerName)"
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top Scores"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

class FinishScene: SKScene {
    var records: [ScoreRecord] = []
    var gameTableView = GameRoomTableView()
    var settings: Settings?
    var playerName: String? = "Player 1"
    var playAgainButton: SKLabelNode!
    var score: Double = 20
    var scoreLabel: SKLabelNode!
    override func didMove(to view: SKView) {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        print(documentsDir)
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = String(score)
        let r = ScoreRecord(playerName: self.playerName!, score: self.score)
        gameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        gameTableView.frame = CGRect(x:20,y:50,width:280,height:200)
        self.scene?.view?.addSubview(gameTableView)
        
        /**
         First we load the data then sort with the highest on top.
         And finally we remove duplicates from the list.
         This will make sure the highest score of the user will stay in the unique list
        */
        loadData()
        self.records.append(r)
        let sorted = records.sorted(by: {(n1:ScoreRecord, n2:ScoreRecord) -> Bool in return n2.score < n1.score})
        let unique = uniq(scores: sorted)
        self.gameTableView.items = unique
        self.gameTableView.reloadData()
        saveData(records: self.records)
    }
    
    /**
     A helper function to strip out records with the same player name from
     a give score record list.
     */
    private func uniq(scores: [ScoreRecord]) -> [ScoreRecord]{
        var seen = Set<String>()
        var unique: [ScoreRecord] = []
        for score in scores {
            /*
             This will check if the seen Set doesnt have the record,
             it adds it to the unique list as well as the seen Set
             */
            if !seen.contains(score.playerName) {
                unique.append(score)
                seen.insert(score.playerName)
            }
        }
        return unique
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let positionInScene = t.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                /*
                 If user touched a node which has the name of
                 playAgainButton button, then transit to the other screen (ie. MenuScene)
                 */
                if name == "playAgainButton"
                {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let sceneTemp =  MenuScene(fileNamed: "MenuScene") as MenuScene?
                    sceneTemp?.scaleMode = .aspectFill
                    sceneTemp?.settings =  Settings(maxBubbles:15, playTime: 60 )
                    gameTableView.removeFromSuperview()
                    self.scene?.view?.presentScene(sceneTemp!, transition: transition)
                }
            }
        }
    }
    
    func saveData(records: [ScoreRecord]) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let archiveURL = documentsDirectory.appendingPathComponent("high_scores").appendingPathExtension("json")
        do {
            let data = try JSONEncoder().encode(records)
            try data.write(to: archiveURL, options: .noFileProtection)
        }
        catch {
            print("Error saving data")
        }
    }
    
    func loadData() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let archiveURL = documentsDirectory.appendingPathComponent("high_scores").appendingPathExtension("json")
        let jsonDecoder = JSONDecoder()
        if let highScoresData = try? Data(contentsOf: archiveURL),
            let decodedHighScores = try? jsonDecoder.decode([ScoreRecord].self, from: highScoresData) {
            self.records = decodedHighScores
            self.gameTableView.items = self.records
            self.gameTableView.reloadData()
        }
    }
    
}
