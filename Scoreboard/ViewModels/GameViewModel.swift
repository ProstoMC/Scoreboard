//
//  ScoreBoardViewModel.swift
//  Scoreboard
//
//  Created by admin on 25.09.24.
//

import Foundation
import SwiftUICore
import Combine

class SetupGameViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    var gameWorker: GameWorker

    @Published var gameName = ""
    @Published var players: [Player] = []
    @Published var maxLevelUsing = false
    @Published var powerUsing = false
    @Published var diceUsing = false
    @Published var gameState: GameState = .notReady
    
    init(gameWorker: GameWorker) {
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

}
//Binding VM with worker
extension GameViewModel {
    private func subscribing() {
        gameWorker.subject.sink(receiveValue: { game in
            
            self.gameName = game.name
            self.players = game.players
            self.maxLevelUsing = game.maxLevelUsing
            self.powerUsing = game.powerUsing
            self.diceUsing = game.diceUsing
            self.gameState = game.state
        }).store(in: &subscriptions)
        
        //Get model after subscribing
        gameWorker.sendSubject()
    }
}



////Internal functions
//extension GameViewModel {
//    
//    private func readyToStartCheck() {
//        if game.players.count > 1 {
//            readyToStart = true
//        }
//        else {
//            readyToStart = false
//        }
//    }
//    
//    
//    private func createNameWithSpacing(name: String) -> String {
//        let arrayOfCharacters = Array(name)
//        var separatedSpace = " "
//        for element in arrayOfCharacters {
//            separatedSpace = separatedSpace + String(element) + " "
//        }
//        
//        return separatedSpace
//    }
//}
