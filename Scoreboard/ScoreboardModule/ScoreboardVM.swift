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
    var gameWorker: ManageGameProtocol = CoreWorker.shared.gameWorker
    private var subscriptions = Set<AnyCancellable>()
   
    @Published var gameState: GameState = .inProgress
    
    @Published var gameName = "G A M E"
    @Published var players: [Player] = [Player(name: "Player 17687687686", colorIndex: 3, closeToWin: true), Player(name: "Player 2", colorIndex: 6)]
    @Published var maxLevelUsing = true
    @Published var stuffUsing = false
    @Published var diceUsing = true
    @Published var diceCount: Int = 3
    @Published var levelToWin: Int = 1
    
    @Published var showSubview: Bool = false
    @Published var typeOfSubview: Subviews = .dice
    @Published var editedPlayer = Player()
    
    @Published var updateTrigger = false //Updating model after some level had changed

    
    init() {
       subscribing()
    }
    
    func setGameState(state: GameState) {
        gameWorker.setGameState(gameState: .paused)
    }
    
    func showEditPlayerSubview(player: Player) {
        editedPlayer = player
        typeOfSubview = .editPlayer
        showSubview = true
    }
    
    func showDiceSubview() {
        typeOfSubview = .dice
        showSubview = true
    }
    
    
}

extension ScoreboardVM {
    
    private func subscribing() {

        //Binding VM with worker
        gameWorker.gameSubject.sink(receiveValue: { game in
            DispatchQueue.main.async{
                self.gameName = self.createNameWithSpacing(name: game.name)
                self.gameState = game.state
                self.players = game.players
                
                self.stuffUsing = game.stuffUsing
                
                self.levelToWin = game.levelToWin
                self.diceCount = game.diceCount
                
                self.maxLevelUsing = false
                self.diceUsing = false
                
                if game.levelToWin > 0 {
                    self.maxLevelUsing = true
                }
                if game.diceCount > 0 {
                    self.diceUsing = true
                }
            }
        }).store(in: &subscriptions)

        //Get model after subscribing
        gameWorker.sendGame()
        
        //Subscribe to update trigger
        
        $updateTrigger.sink(receiveValue: { flag in
            if flag {
                for i in self.players.indices {
                    if self.players[i].id == self.editedPlayer.id {
                        self.players[i] = self.editedPlayer
                    }
                }
                self.editedPlayer = Player()
                self.players.sort { ($0.level, $0.stuff) > ($1.level, $1.stuff) }
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
