//
//  ResultViewController.swift
//  memo
//
//  Created by Artsiom Sadyryn on 12/27/17.
//  Copyright © 2017 Artsiom Sadyryn. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
    
    let gameService = StatsService()
    static let bestResultIdentifier = "BestResultTableViewCell"
    static let commonResultIdentifier = "ResultTableViewCell"
    
    var table: UITableView!
    var results: [GameResult]?
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table = UITableView()
        view.addSubViews(table, margins: UIEdgeInsets.zero)
        table.dataSource = self
        table.register(BestResultTableViewCell.self, forCellReuseIdentifier: ResultViewController.bestResultIdentifier)
        table.register(UINib.init(nibName: "ResultTableviewCell", bundle: nil), forCellReuseIdentifier: ResultViewController.commonResultIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        results = gameService.getResults()
        prepareData()
        table.reloadData()
        let result = results?.first
        resultLabel.text = "Last game stats: \(result?.pairs) \(result?.steps) \(result?.time)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultViewController.bestResultIdentifier) as! BestResultTableViewCell
            let result = results?[indexPath.row]
            cell.label.text = "game stats: \(result!.score()) \(result!.steps) \(result!.time)"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultViewController.commonResultIdentifier) as! ResultTableViewCell
            let result = results?[indexPath.row]
            cell.resultLabel.text = "game stats: \(result!.score()) \(result!.steps) \(result!.time)"
            return cell
        }
    }
    
    private func prepareData() {
        guard let result = results else {
            return
        }
        
        if result.count <= 3 {
            results = results?.sorted(by: { $0.score() > $1.score()} )
        }
        else {
            let topResults = results?.sorted(by: { $0.score() > $1.score()} )[0...2]
            results = Array(topResults!) + result
        }
    }
}
