//
//  GameModel.swift
//  Scoreboard
//
//  Created by admin on 24.09.24.
//

import Foundation
import SwiftUI

struct GameModel: Identifiable {
    let id = UUID()
    var name: String = ""
    
    var stuffUsing: Bool = false
    var diceCount: Int = 0
    var levelToWin: Int = 0
    
    var players: [Player] = []
    var winner: Player! = nil
    
    var state: GameState = .new
}

struct Player: Identifiable, Hashable {
    let id = UUID()
    var name: String = ""
    var level: Int = 0
    var stuff: Int = 0
    var colorIndex: Int = 0
    
    var closeToWin: Bool = false // For highlighting player cell when it close to win
}



let playerColors: [Color] = [.black, .red, .blue, .white, .green, .yellow, .brown, .gray, .purple, .orange]

enum ActionsWithPlayer {
    case none
    case newPlayer
    case editPlayer
}

enum GameState: String {
    case new = "New"
    case readyToStart = "Ready to start"
    case inProgress = "In progress"
    case finished = "Finished"
    case paused = "Paused"
    case empty = "Empty"
}

enum AppState {
    case noActiveGames
    case gameStarting
    case gameEnded
}

enum Subviews: String {
    case scoreboard
    case setupGame
    case dice
    case maxLevel
    case editPlayer
}
