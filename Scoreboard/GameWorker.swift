//
//  Untitled.swift
//  Scoreboard
//
//  Created by admin on 01.10.24.
//

import Foundation
import Combine
import SwiftUI

protocol SetupGameProtocol {
    
    func setGame(game: GameModel)
    func resetGame()
    func sendGame()
    func returnGame() -> GameModel
}

protocol ManageGameProtocol {
    var gameSubject: PassthroughSubject<GameModel, Never> { get }
    
    func sendGame()
    func resetGame()
    func setGameState(gameState: GameState)
    func returnGame() -> GameModel
    
    func rangePlayersByLevel()
    func updatePlayers(players: [Player])
}

class GameWorker {
    
    var game = GameModel()
    var gameSubject = PassthroughSubject<GameModel, Never>()
    
    private var savingNumber = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        subscribing()
        getGameFromUserDefaults()
        
    }
    
    func sendGame() {
        gameSubject.send(game)
        
    }
    
    func setGameState(gameState: GameState) {
        game.state = gameState
        sendGame()
    }
    func returnGameState() -> GameState {
        game.state
    }
    
    func returnGame() -> GameModel {
        game
    }
    func setGame(game: GameModel) {
        self.game = game
        
        sendGame()
    }
    
    func createNewGameFromTemplate(template: GameModel) {
        self.game = template
        for i in game.players.indices {
            game.players[i].level = 0
            game.players[i].stuff = 0
        }
        game.state = .inProgress
        sendGame()
    }
}


extension GameWorker: SetupGameProtocol {
    func resetGame() {
        game = GameModel() //Just create new empty game
        sendGame()
    }
}

extension GameWorker: ManageGameProtocol {
    func rangePlayersByLevel() {
        game.players.sort { $0.level < $1.level }
        sendGame()
    }
    
    func updatePlayers(players: [Player]) {
        game.players = players
        if game.levelToWin != 0 {
            checkPlayersForCloseToWin()
        }
        sendGame()
    }
}


//Internal functions
extension GameWorker {

    private func checkPlayersForCloseToWin() {
        for i in game.players.indices {
            if game.players[i].level >= game.levelToWin - 2 ||
                    Double(game.players[i].level) >= Double(game.levelToWin)*0.8 {
                
                game.players[i].closeToWin = true
            }
            else {
                game.players[i].closeToWin = false
            }
        }
    }
    
    
    private func printTraits() {
        print("---\(game.name)---")
        print("Level to win: \(game.levelToWin)")
        print("Dice count: \(game.diceCount)")
        print("Power using: \(game.stuffUsing)")
    }
}


//MARK: - USER DEFAULTS
extension GameWorker {
    
    func subscribing() {
        gameSubject.sink { [weak self] _ in
            self?.saveGameToUserDefaults()
        }.store(in: &subscriptions)
    }
    
    func saveGameToUserDefaults() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(game) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "currentGame")
            print("--- Game - \(game.name) - saved --- \(savingNumber)")
            savingNumber += 1
        }
    }
    
    func getGameFromUserDefaults() {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "currentGame") as? Data {
            let decoder = JSONDecoder()
            if let savedGame = try? decoder.decode(GameModel.self, from: data) {
                self.game = savedGame
            }
        }
    }
}
