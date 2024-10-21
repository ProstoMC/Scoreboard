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
    
    @Published var gameState: GameState = .new
    
    @Published var setupViewType: String = ""
    
    init() {
        gameWorker.readyToStartCheck()
        subscribing()
    }
    
    func addPlayer(newPlayer: Player) {
        gameWorker.addPlayer(newPlayer: newPlayer)
    }
    
    func deletePlayer(index: Int) {
        gameWorker.deletePlayer(index: index)
    }
    
    func resetGame() {
        gameWorker.resetGame()
    }
    
    func togglePowerUsing() {
        stuffUsing.toggle()
        saveTraits()
    }
    
    func setGameToStart() {
        if gameName == "" {
            gameWorker.setGameName(name: "New game")
        }
        gameWorker.setGameState(gameState: .inProgress)
    }
    
    func setGameName() {
        print("GAME'S NAME: \(gameName)")
        gameWorker.setGameName(name: gameName)
    }
    
    func saveTraits() {
        gameWorker.setTraits(
            levelToWin: levelToWin,
            diceCount: diceCount,
            powerUsing: stuffUsing
        )
    }
    
}
//Binding VM with worker
extension SetupGameVM {
    private func subscribing() {
        gameWorker.gameSubject.sink(receiveValue: { game in
            
            DispatchQueue.main.async {
                //print("Game updated in Setup Module")
                
                self.players = game.players
                
                self.stuffUsing = game.stuffUsing
                self.levelToWin = game.levelToWin
                self.diceCount = game.diceCount
                
                
                self.gameState = game.state
                self.gameName = game.name
                
                
                //Setup image and traits
                
                self.gameImageName = "play.circle"
                self.maxLevelUsing = false
                self.diceUsing = false
                
                if game.levelToWin > 0 {
                    self.gameImageName = "arrowshape.up"
                    self.maxLevelUsing = true
                }
                if game.diceCount > 0 {
                    self.gameImageName = "dice"
                    self.diceUsing = true
                }
            }
        }).store(in: &subscriptions)
        
        //Get model after subscribing
        gameWorker.sendGame()
    }
}

