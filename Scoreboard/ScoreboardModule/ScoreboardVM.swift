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
   
    @Published var gameState: GameState = .hasAWinner
    
    @Published var gameName = "G A M E"
    @Published var players: [Player] = [
        Player(name: "Player 1768", colorIndex: 3, closeToWin: true),
        Player(name: "Player 2", colorIndex: 6),
        Player(name: "Random"),
        Player(name: "Bot Rock")]
    
    @Published var timerUsing = true
    @Published var maxLevelUsing = true
    @Published var stuffUsing = false
    @Published var diceUsing = true
    @Published var diceCount: Int = 3
    @Published var levelToWin: Int = 1
    @Published var infoWinnerText: String = ""
    
    
    @Published var showSubview: Bool = false
    @Published var typeOfSubview: Subviews = .dice
    @Published var editedPlayer = Player()
    
    @Published var updateTrigger = false //Updating model after some level had changed

    
    init() {
        getGameFromWorker()
        subscribing()
        
    }
    
    func setGameStateToWorker() {
        gameWorker.setGameState(gameState: gameState)
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
    
    func editButtonPressed() {
        gameWorker.setGameState(gameState: .edited)
        typeOfSubview = .setupGame
        showSubview = true
    }
    
    func scoreButtonPressed() {
        typeOfSubview = .winner
        showSubview = true
    }
    
    
}


//MARK: - INTERNAL FUNCS
extension ScoreboardVM {
    
    func getGameFromWorker() {
        let game = gameWorker.returnGame()
        
        gameName = createNameWithSpacing(name: game.name)
        gameState = game.state
        players = game.players
        
        stuffUsing = game.stuffUsing
        
        levelToWin = game.levelToWin
        diceCount = game.diceCount
        
        maxLevelUsing = false
        diceUsing = false
        
        if game.levelToWin > 0 {
            maxLevelUsing = true
        }
        if game.diceCount > 0 {
            diceUsing = true
        }
        
        manageEndOfGame()
        
    }

    private func subscribing() {
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
                self.manageEndOfGame()
            }
        }).store(in: &subscriptions)
    }

    private func manageEndOfGame() {
        
        //Update players for update cell apperance
        players = gameWorker.returnGame().players
        
        if !maxLevelUsing { return }
        
        var havingWinner: Bool = false
        
        //Looking for a winner
        for player in players {
            if player.level >= levelToWin {
                havingWinner = true
                break
            }
        }
        
        if !havingWinner {
            infoWinnerText = "🏆 First to rich \(levelToWin) wins"
            gameState = .inProgress
            setGameStateToWorker()
            return
        }
        
        //Manage winner part
        infoWinnerText = "🏆 Winner: \(players.first?.name ?? "")"
        
        //Show winner view only for a first time
        if gameState == .inProgress {
            gameState = .hasAWinner
            setGameStateToWorker()
            
            typeOfSubview = .winner
            showSubview = true
        }
    }
    
}

//Internal funcs

extension ScoreboardVM {
    private func createNameWithSpacing(name: String) -> String {
        let arrayOfCharacters = Array(name)
        var separatedSpace = " "
        for element in arrayOfCharacters {
            separatedSpace = separatedSpace + String(element) + " "
        }
        
        return separatedSpace.uppercased()
    }
}
