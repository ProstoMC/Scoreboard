//
//  ScoreboardVM.swift
//  Scoreboard
//
//  Created by admin on 02.10.24.
//

import Foundation
import Combine
import SwiftUI

class ScoreboardVM: ObservableObject {
    var gameWorker: ManageGameProtocol
    private var subscriptions = Set<AnyCancellable>()
   
    @Published var gameState: GameState = .inProgress
    
    @Published var gameName = "G A M E"
    @Published var players: [Player] = [Player(name: "Player 1", colorIndex: 3), Player(name: "Player 2", colorIndex: 6)]
    @Published var maxLevelUsing = true
    @Published var powerUsing = false
    @Published var diceUsing = true
    @Published var levelToWin: Int = 0
    
    @Published var levelsChanged = false //Updating model after some level had changed

    
    init(gameWorker: ManageGameProtocol) {
        self.gameWorker = gameWorker
        subscribing()
    }
}

extension ScoreboardVM {
    
    private func subscribing() {

        //Binding VM with worker
        gameWorker.gameSubject.sink(receiveValue: { game in
            DispatchQueue.main.async{
                self.gameName = self.createNameWithSpacing(name: game.name)
                self.players = game.players
                self.maxLevelUsing = game.maxLevelUsing
                self.powerUsing = game.powerUsing
                self.diceUsing = game.diceUsing
                self.gameState = game.state
                self.levelToWin = game.levelToWin
                
                //self.players.sort { $0.level > $1.level }
            }
        }).store(in: &subscriptions)

            
        //Get model after subscribing
        gameWorker.sendGame()
        
        $levelsChanged.sink(receiveValue: { flag in
            if flag {
                self.players.sort { $0.level > $1.level }
                self.gameWorker.updatePlayers(players: self.players)
            }
        }).store(in: &subscriptions)
    }
    
    private func createNameWithSpacing(name: String) -> String {
        let arrayOfCharacters = Array(name)
        var separatedSpace = " "
        for element in arrayOfCharacters {
            separatedSpace = separatedSpace + String(element) + " "
        }
        
        return separatedSpace.uppercased()
    }
    
}
