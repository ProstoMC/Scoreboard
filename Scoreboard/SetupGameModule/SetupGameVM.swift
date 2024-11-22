//
//  ScoreBoardViewModel.swift
//  Scoreboard
//
//  Created by admin on 25.09.24.
//

import Foundation
import SwiftUICore
import Combine
import SwiftUI

class SetupGameVM: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    var gameWorker: SetupGameProtocol = CoreWorker.shared.gameWorker
    
    @Published var gameImageName: String = ""
    @Published var gameName = ""
    @Published var players: [Player] = []
    
    
    @Published var stuffUsing = false
    
    @Published var maxLevelUsing = false
    @Published var levelToWin: Int = 0
    
    @Published var diceUsing = false
    @Published var diceCount: Int = 0
    @Published var readyToStart: Bool = false
    
    @Published var gameState: GameState = .new
    
    @Published var setupViewType: String = ""
    
    init() {
        getGame()
        
    }
    
    
//MARK: - VIEWS FUNCS
    
    func addPlayer(newPlayer: Player) {
        if canSavePlayer(player: newPlayer) {
            players.append(newPlayer)
        }
        checkToStartGame()
    }
    
    func deletePlayer(index: Int) {
        players.remove(at: index)
        checkToStartGame()
    }

    func togglePowerUsing() {
        stuffUsing.toggle()
    }
    
    func setTraitsButtons() {
        if diceCount > 0 {
            diceUsing = true
        }
        else {
            diceUsing = false
        }
        
        if levelToWin > 0 {
            maxLevelUsing = true
        }
        else {
            maxLevelUsing = false
        }
        
        setImage()
        
    }
    
//MARK: - WORKER FUNCS
    
    func resetGame() {
        gameWorker.resetGame()
        getGame()
    }
    
    func setGameToStart() {
        if gameName == "" {
            gameName = "New game"
        }
        gameState = .inProgress
        saveGameToWorker()
    }
    
    func saveGameToWorker() {
        let game = GameModel(
            name: gameName,
            systemImageName: gameImageName,
            
            stuffUsing: stuffUsing,
            diceCount: diceCount,
            levelToWin: levelToWin,
            
            players: players,
            state: gameState
        )
        gameWorker.setGame(game: game)
    }
    
    private func getGame() {
        let game = gameWorker.returnGame()
        self.players = game.players
        
        self.stuffUsing = game.stuffUsing
        self.levelToWin = game.levelToWin
        self.diceCount = game.diceCount
        
        
        self.gameState = game.state
        self.gameName = game.name
        
        setTraitsButtons()
        checkToStartGame()
    }
}


//MARK: - INTERNAL FUNCS
extension SetupGameVM {
    private func checkToStartGame() {
        if players.count > 1 {
            readyToStart = true
        }
        else {
            readyToStart = false
        }
    }

    private func setImage() {
        gameImageName = "play.circle"
        if levelToWin > 0 {
            self.gameImageName = "arrowshape.up"
        }
        if diceCount > 0 {
            self.gameImageName = "dice"
        }
    }
    
    private func canSavePlayer(player: Player) -> Bool {
        if player.name == "" || player.name == " " {
            return false
        }
        for existPlayer in players {
            if player.name == existPlayer.name {
                return false
            }
        }
        return true
    }
}

