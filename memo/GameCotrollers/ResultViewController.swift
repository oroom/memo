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
    
    var table: UITableView!
    var results: [GameResult]?
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table = UITableView()
        view.addSubViews(table, margins: UIEdgeInsets.zero)
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        results = gameService.getResults()
        table.reloadData()
        let result = results?.first
        resultLabel.text = "Last game stats: \(result?.pairs) \(result?.steps) \(result?.time)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let result = results?[indexPath.row]
        cell.textLabel?.text = "game stats: \(result!.pairs) \(result!.steps) \(result!.time)"
        return cell
    }
}
