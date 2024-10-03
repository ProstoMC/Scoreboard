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
    
    var gameWorker: SetupGameProtocol
    
    @Published var gameImageName: String = ""
    @Published var gameName = ""
    @Published var players: [Player] = []
    @Published var maxLevelUsing = false
    @Published var powerUsing = false
    @Published var diceUsing = false
    @Published var gameState: GameState = .notReady
    
    init(gameWorker: SetupGameProtocol) {
        self.gameWorker = gameWorker
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
    
    func toggleTrait(trait: String) {
        gameWorker.toggleTrait(trait: trait)
    }
    
    func setGameToStart() {
        gameWorker.setGameState(gameState: .inProgress)
    }
    
    func setGameName() {
        print("GAME'S NAME: \(gameName)")
        gameWorker.setGameName(name: gameName)
    }
    
}
//Binding VM with worker
extension SetupGameVM {
    private func subscribing() {
        gameWorker.gameSubject.sink(receiveValue: { game in
            
            DispatchQueue.main.async {
                self.players = game.players
                self.maxLevelUsing = game.maxLevelUsing
                self.powerUsing = game.powerUsing
                self.diceUsing = game.diceUsing
                self.gameState = game.state
                self.gameName = game.name
                //Setup image
                self.gameImageName = "play.circle"
                if game.maxLevelUsing { self.gameImageName = "arrowshape.up" }
                if game.diceUsing { self.gameImageName = "dice" }
            }
            
            
        }).store(in: &subscriptions)
        
        //Get model after subscribing
        gameWorker.sendGame()
    }
}

