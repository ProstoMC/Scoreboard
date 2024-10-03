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
    func toggleTrait(trait: String)
    func resetGame()
    func setGameState(gameState: GameState)
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
    
    init() {
        //print("GameWorker has been initialized")
        //subscribingToPlayersLevel()
    }
    
    func sendGame() {
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
    
    func toggleTrait(trait: String) {
        switch trait {
        case "diceUsing":
            game.diceUsing.toggle()
        case "powerUsing":
            game.powerUsing.toggle()
        case "maxLevelUsing":
            game.maxLevelUsing.toggle()
        default:
            return
        }
        sendGame()
    }
    

    
    func setGameName(name: String) {
        game.name = name
        print(game.name)
    }
}

extension GameWorker: ManageGameProtocol {
    func rangePlayersByLevel() {
        game.players.sort { $0.level < $1.level }
//        for player in game.players {
//            print("\(player.name) is at level \(player.level)")
//        }
        sendGame()
    }
    
    func updatePlayers(players: [Player]) {
        game.players = players
//        game.players.sort { $0.level > $1.level }
//        sendGame()
    }
}


//Internal functions
extension GameWorker {
    
//    private func subscribingToPlayersLevel() {
//        for player in game.players {
//            let 
//        }
//    }
    
    private func readyToStartCheck() {
        if game.players.count > 1 {
            game.state = .readyToStart
        }
        else {
            game.state = .notReady
        }
    }
    
}
