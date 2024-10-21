//
//  Untitled.swift
//  Scoreboard
//
//  Created by admin on 01.10.24.
//

import Foundation
import Combine

protocol SetupGameProtocol {
    
    var gameSubject: PassthroughSubject<GameModel, Never> { get }
    
    func addPlayer(newPlayer: Player)
    func deletePlayer(index: Int)
    func setTraits(levelToWin: Int, diceCount: Int, powerUsing: Bool)
    func readyToStartCheck()
    
    func resetGame()
    func setGameState(gameState: GameState)
    func getGameState() -> GameState
    func setGameName(name: String)
    func sendGame()
   
    
}

protocol ManageGameProtocol {
    var gameSubject: PassthroughSubject<GameModel, Never> { get }
    
    func sendGame()
    func resetGame()
    func setGameState(gameState: GameState)
    
    func rangePlayersByLevel()
    func updatePlayers(players: [Player])
}

class GameWorker {
    
    private var game = GameModel()
    var gameSubject = PassthroughSubject<GameModel, Never>()
    
    
    private var subscriptions = Set<AnyCancellable>()
    
    func sendGame() {
        print("Game state: \(game.state.rawValue)")
        gameSubject.send(game)
    }
    
    func resetGame() {
        game = GameModel() //Just create new empty game
        sendGame()
    }
    
    func setGameState(gameState: GameState) {
        game.state = gameState
        sendGame()
    }
    func getGameState() -> GameState {
        game.state
    }
 
    
}

extension GameWorker: SetupGameProtocol {
    func addPlayer(newPlayer: Player) {
        print("Game worker added player: \(newPlayer.name)")
        if newPlayer.name == "" { return }
        for player in game.players {
            if newPlayer.name == player.name {
                return
            }
        }
        game.players.append(newPlayer)
        readyToStartCheck()
        sendGame()
    }
    
    func deletePlayer(index: Int) {
        game.players.remove(at: index)
        readyToStartCheck()
        sendGame()
    }
    
    func setTraits(levelToWin: Int, diceCount: Int, powerUsing: Bool) {
        game.levelToWin = levelToWin
        game.diceCount = diceCount
        game.stuffUsing = powerUsing
        printTraits()
        sendGame()
    }

    func setGameName(name: String) {
        game.name = name
    }
    
    func readyToStartCheck() {
        if game.players.count > 1 {
            game.state = .readyToStart
        }
        else {
            game.state = .new
        }
    }
}

extension GameWorker: ManageGameProtocol {
    func rangePlayersByLevel() {
        game.players.sort { $0.level < $1.level }
        sendGame()
    }
    
    func updatePlayers(players: [Player]) {
        game.players = players
        checkPlayersForCloseToWin()
        sendGame()
    }
}


//Internal functions
extension GameWorker {

    private func checkPlayersForCloseToWin() {
        for i in game.players.indices {
            if game.players[i].level >= game.levelToWin - 1 ||
                Double(game.players[i].level) >= Double(game.levelToWin)*0.9 {
                
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
