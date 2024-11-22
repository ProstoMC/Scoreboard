//
//  GameModel.swift
//  Scoreboard
//
//  Created by admin on 24.09.24.
//

import Foundation
import SwiftUI

struct GameModel: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String = ""
    var systemImageName = "play.circle"
    
    var stuffUsing: Bool = false
    var diceCount: Int = 0
    var levelToWin: Int = 0
    
    var players: [Player] = []
    var winner: Player! = nil
    
    var state: GameState = .new
    var date: Date = .now
}


struct Player: Identifiable, Hashable, Codable {
    
    var id = UUID()
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

enum GameState: String, Codable {
    case new = "New"
    case inProgress = "In progress"
    case hasAWinner = "Has a winner"
    case finished = "Finished"
    case paused = "Paused"
    case empty = "Empty"
    case edited = "Edited"
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
    case winner
}

struct PreferedColorScheme: EnvironmentKey {
    static let defaultValue: ColorScheme = .dark
}
