//
//  HistoryViewController.swift
//  mazedash
//
//  Created by Clement Gan on 29/12/2024.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // This will store the game history records
    var gameHistory: [GameHistory] = []
    
    // TableView to display game history
    var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view
        view.backgroundColor = .white
        title = "Game History"
        
        // Load saved game history from UserDefaults
        loadGameHistory()
        
        // Set up the table view
        historyTableView = UITableView(frame: view.bounds, style: .plain)
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        // Register a custom cell if needed (or use default cell style)
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        
        // Add table view to the view hierarchy
        view.addSubview(historyTableView)
        
        // Reload the table view with the loaded history
        historyTableView.reloadData()
    }
    
    // MARK: - TableView DataSource & Delegate Methods
    
    // Number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameHistory.count
    }
    
    // Set up each cell to display the steps and time
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        
        // Get the game history record for the current row
        let history = gameHistory[indexPath.row]
        
        // Set the cell text to show steps and time
        cell.textLabel?.text = "Steps: \(history.steps) | Time: \(String(format: "%.2f", history.time)) sec"
        
        return cell
    }
    
    // MARK: - Load Game History from UserDefaults
    
    func loadGameHistory() {
        // Retrieve the data from UserDefaults
        if let savedHistory = UserDefaults.standard.data(forKey: "gameHistory") {
            // Decode the data into the gameHistory array
            if let decodedHistory = try? JSONDecoder().decode([GameHistory].self, from: savedHistory) {
                gameHistory = decodedHistory
            }
        }
    }
}
