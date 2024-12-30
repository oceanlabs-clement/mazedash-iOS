//
//  ViewController.swift
//  mazedash
//
//  Created by Clement Gan on 29/12/2024.
//

import UIKit

struct GameHistory: Codable {
    var steps: Int
    var time: TimeInterval
}

class ViewController: UIViewController {
    
    // Define maze dimensions
    let rows = 10
    let cols = 10
    var maze: [[Int]] = []
    var playerPosition = (row: 0, col: 0)
    var exitPosition = (row: 9, col: 9)
    
    var gameHistory: [GameHistory] = []
    
    // UI Elements
    var mazeView: UIView = UIView()
    var playerView: UIView = UIView()
    var exitView: UIView = UIView()
    var scoreLabel: UILabel = UILabel()
    
    let maze1 = [
        [0, 1, 0, 0, 0, 0, 1, 1, 0, 0],
        [0, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 0],
        [1, 1, 1, 0, 1, 0, 1, 1, 0, 0],
        [0, 0, 0, 0, 1, 1, 1, 0, 0, 1],
        [1, 0, 1, 1, 1, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 0, 1, 0, 0, 1, 0],
        [0, 1, 0, 0, 0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 1, 0, 1, 0, 1, 0]
    ]
    
    let maze2 = [
        [0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 1, 1, 1, 0, 1, 0, 1, 1, 0],
        [0, 1, 0, 0, 0, 0, 0, 0, 1, 0],
        [0, 1, 0, 1, 1, 1, 1, 1, 1, 0],
        [0, 1, 0, 1, 0, 0, 0, 1, 0, 0],
        [0, 1, 0, 0, 0, 1, 0, 1, 0, 1],
        [0, 1, 1, 1, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 1, 0, 1, 1, 0],
        [0, 1, 0, 1, 0, 1, 0, 1, 0, 0],
        [0, 0, 0, 1, 0, 1, 0, 0, 1, 0]
    ]
    
    let maze3 = [
        [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
        [1, 1, 1, 0, 1, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
        [0, 0, 0, 0, 1, 1, 1, 1, 1, 0],
        [0, 1, 1, 1, 0, 1, 0, 0, 1, 0],
        [0, 1, 1, 0, 1, 1, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0, 1, 0, 1],
        [1, 0, 0, 0, 1, 1, 0, 1, 0, 0],
        [0, 0, 1, 1, 0, 0, 1, 0, 1, 0],
        [0, 1, 0, 0, 0, 0, 1, 0, 0, 0]
    ]
    
    let maze4 = [
        [0, 1, 0, 0, 0, 0, 1, 0, 0, 0],
        [0, 1, 0, 1, 1, 0, 1, 0, 1, 0],
        [0, 1, 0, 0, 1, 0, 0, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 1, 1, 0, 0],
        [1, 1, 1, 0, 1, 0, 0, 1, 0, 1],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 0, 1, 1, 1, 0, 1],
        [0, 0, 1, 1, 1, 0, 0, 0, 1, 0],
        [0, 1, 1, 0, 0, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 1, 0, 1, 0, 0, 0]
    ]
    
    let maze5 = [
        [0, 0, 0, 0, 0, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 0, 0, 0, 0, 1, 0],
        [0, 1, 0, 0, 1, 0, 1, 1, 0, 0],
        [0, 1, 1, 1, 0, 1, 0, 0, 0, 1],
        [0, 0, 0, 0, 1, 0, 0, 1, 1, 0],
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 1, 0, 1, 1, 1, 1, 1],
        [1, 1, 0, 1, 0, 0, 1, 0, 0, 0],
        [1, 0, 0, 0, 1, 0, 0, 0, 1, 0],
        [0, 0, 1, 0, 1, 0, 0, 1, 1, 0]
    ]
    
    var moveCount = 0
    var gameOver = false
    
    var timer: Timer?
    var startTime: Date?
    var elapsedTime: TimeInterval = 0
    var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true  // Hide back button on game screen
        
        setupUI()
        setupMaze()
        setupPlayer()
        setupExit()
        setupTimer()       // Add the timer
        setupInstructions() // Add the instructions
        setupQuitButton()   // Add the quit button
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        view.backgroundColor = .white
        
        // Setup background image
        let bgColorView = UIView(frame: view.bounds)
        bgColorView.backgroundColor = UIColor(red: 223.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.addSubview(bgColorView)
        
        // Maze view (container for maze cells)
        let mazeSize = CGSize(width: CGFloat(cols) * 30, height: CGFloat(rows) * 30)
        mazeView = UIView(frame: CGRect(x: (view.frame.width - mazeSize.width) / 2, y: 150, width: mazeSize.width, height: mazeSize.height))
        mazeView.layer.borderWidth = 2
        mazeView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(mazeView)
        
        // Score label
        scoreLabel = UILabel()
        scoreLabel.frame = CGRect(x: (view.frame.width - 200) / 2, y: mazeView.frame.maxY + 20, width: 200, height: 30)
        scoreLabel.text = "Moves: 0"
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        view.addSubview(scoreLabel)
        
        // Swipe gestures for movement
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(moveUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(moveDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(moveLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(moveRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    // MARK: - Setup Maze
    
    func setupMaze() {
        maze = [
            [0, 1, 0, 0, 0, 0, 1, 1, 0, 0],
            [0, 1, 0, 1, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 1, 0, 1, 0, 1, 0],
            [1, 1, 1, 0, 1, 0, 1, 1, 0, 0],
            [0, 0, 0, 0, 1, 1, 1, 0, 0, 1],
            [1, 0, 1, 1, 1, 0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0, 1, 1, 0, 0, 0],
            [0, 1, 1, 1, 0, 1, 0, 1, 0, 0],
            [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 1, 0, 0, 1, 1, 0]
        ]
        
        let randomIndex = Int.random(in: 0...4)
        switch randomIndex {
        case 0:
            maze = maze1
        case 1:
            maze = maze2
        case 2:
            maze = maze3
        case 3:
            maze = maze4
        default:
            maze = maze5
        }
        
        // Draw maze grid
        let cellSize: CGFloat = 30
        for row in 0..<rows {
            for col in 0..<cols {
                let cell = UIView(frame: CGRect(x: CGFloat(col) * cellSize, y: CGFloat(row) * cellSize, width: cellSize, height: cellSize))
                if maze[row][col] == 1 {
                    cell.backgroundColor = .black // Wall
                } else {
                    cell.backgroundColor = .white // Path
                }
                mazeView.addSubview(cell)
            }
        }
    }
    
    // MARK: - Setup Player and Exit
    
    func setupPlayer() {
        playerView = UIView(frame: CGRect(x: CGFloat(playerPosition.col) * 30, y: CGFloat(playerPosition.row) * 30, width: 30, height: 30))
        playerView.backgroundColor = .blue
        mazeView.addSubview(playerView)
    }
    
    func setupExit() {
        exitView = UIView(frame: CGRect(x: CGFloat(exitPosition.col) * 30, y: CGFloat(exitPosition.row) * 30, width: 30, height: 30))
        exitView.backgroundColor = .green
        mazeView.addSubview(exitView)
    }
    
    func setupTimer() {
        // Timer label
        timerLabel = UILabel()
        timerLabel.frame = CGRect(x: (view.frame.width - 200) / 2, y: 80, width: 200, height: 30)
        timerLabel.textAlignment = .center
        timerLabel.text = "Time: 0.0s"
        timerLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        view.addSubview(timerLabel)
        
        // Start the timer when the game starts
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        guard let startTime = startTime else { return }
        elapsedTime = Date().timeIntervalSince(startTime)
        timerLabel.text = String(format: "Time: %.1fs", elapsedTime)
    }
    
    func setupInstructions() {
        let instructionsLabel = UILabel()
        instructionsLabel.frame = CGRect(x: 20, y: mazeView.frame.maxY + 50, width: view.frame.width - 40, height: 100)
        instructionsLabel.textAlignment = .center
        instructionsLabel.numberOfLines = 0
        instructionsLabel.text = """
        Swipe Up, Down, Left, Right to move.
        Reach the Green block to win!
        """
        instructionsLabel.font = UIFont.systemFont(ofSize: 16)
        instructionsLabel.textColor = .black
        view.addSubview(instructionsLabel)
    }
    
    func setupQuitButton() {
        let quitButton = UIButton(type: .system)
        quitButton.frame = CGRect(x: (view.frame.width - 200) / 2, y: view.frame.height - 100, width: 200, height: 50)
        quitButton.setTitle("Quit", for: .normal)
        quitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        quitButton.layer.borderWidth = 2
        quitButton.layer.borderColor = UIColor.systemBlue.cgColor
        quitButton.layer.cornerRadius = 20
        quitButton.addTarget(self, action: #selector(quitGame), for: .touchUpInside)
        view.addSubview(quitButton)
    }
    
    @objc func quitGame() {
        // Here, you can simply dismiss the view controller or take any other action
        // If this view controller is being presented modally, you can dismiss it like so:
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
        // Alternatively, if you want to reset the game:
        // You can reset the maze, timer, and other game components as needed.
    }
    
    // MARK: - Movement Functions
    
    @objc func moveUp() {
        guard !gameOver else { return }
        if playerPosition.row > 0 && maze[playerPosition.row - 1][playerPosition.col] == 0 {
            playerPosition.row -= 1
            movePlayer()
        }
    }

    @objc func moveDown() {
        guard !gameOver else { return }
        if playerPosition.row < rows - 1 && maze[playerPosition.row + 1][playerPosition.col] == 0 {
            playerPosition.row += 1
            movePlayer()
        }
    }

    @objc func moveLeft() {
        guard !gameOver else { return }
        if playerPosition.col > 0 && maze[playerPosition.row][playerPosition.col - 1] == 0 {
            playerPosition.col -= 1
            movePlayer()
        }
    }

    @objc func moveRight() {
        guard !gameOver else { return }
        if playerPosition.col < cols - 1 && maze[playerPosition.row][playerPosition.col + 1] == 0 {
            playerPosition.col += 1
            movePlayer()
        }
    }
    
    func movePlayer() {
        // Move player view to the new position
        playerView.frame.origin = CGPoint(x: CGFloat(playerPosition.col) * 30, y: CGFloat(playerPosition.row) * 30)
        
        // Check if player reaches the exit
        if playerPosition == exitPosition {
            scoreLabel.text = "You Win!"
            
            // Save the game history (steps and time)
            let steps = playerPosition.row + playerPosition.col
            let timeTaken = elapsedTime
            let gameRecord = GameHistory(steps: steps, time: timeTaken)
            gameHistory.append(gameRecord)
            
            // Save to UserDefaults
            saveGameHistory()
            
            // Show Game Over alert with options
            showGameOverAlert()
        } else {
            scoreLabel.text = "Moves: \(playerPosition.row + playerPosition.col)"
        }
    }
    
    func showGameOverAlert() {
        let alertController = UIAlertController(title: "Game Over", message: "You have completed the maze!", preferredStyle: .alert)
        
        // Action for New Game
        let newGameAction = UIAlertAction(title: "New Game", style: .default) { _ in
            self.setupMaze()
            self.setupPlayer()
            self.setupExit()
            
            self.startTime = Date()
            self.timer?.invalidate()
            self.timer = nil
            self.timerLabel.text = "Time: 0.0s"
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        }
        
        // Action for Exit Game
        let exitGameAction = UIAlertAction(title: "Exit Game", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: false)
        }
        
        // Add actions to the alert
        alertController.addAction(newGameAction)
        alertController.addAction(exitGameAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    func saveGameHistory() {
        // Convert gameHistory array to Data
        if let encoded = try? JSONEncoder().encode(gameHistory) {
            UserDefaults.standard.set(encoded, forKey: "gameHistory")
        }
    }
    
}

