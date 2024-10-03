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
    var diceUsing: Bool = false
    var powerUsing: Bool = false
    var maxLevelUsing: Bool = false
    var levelToWin: Int = 10
    
    var players: [Player] = []
    var winner: Player! = nil
    

    
    var state: GameState = .notReady
}

struct Player: Identifiable, Hashable {
    let id = UUID()
    var name: String = ""
    var level: Int = 0
    var power: Int = 0
    var colorIndex: Int = 0
}

let playerColors: [Color] = [.black, .red, .blue, .white, .green, .yellow, .brown, .gray, .purple, .orange]

enum ActionsWithPlayer {
    case none
    case newPlayer
    case editPlayer
}

enum GameState {
    case notReady
    case readyToStart
    case inProgress
    case finished
    case paused
}

enum AppState {
    case noActiveGames
    case gameStarting
    case gameEnded
}
