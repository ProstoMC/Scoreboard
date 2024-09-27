//
//  ScoreBoardViewModel.swift
//  Scoreboard
//
//  Created by admin on 25.09.24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var players: [Player] = []
    @Published var name: String = ""
    
    func setupModelView(game: GameModel) {
        players = game.players
        
        name = createNameWithSpacing(name: game.name)
    }
    
    func addPlayer(newPlayer: Player) {
        print("Added player: \(newPlayer.name)")
        if newPlayer.name == "" { return }
        for player in players {
            if newPlayer.name == player.name {
                return
            }
        }
        players.append(newPlayer)
    }

    
    func createNameWithSpacing(name: String) -> String {
        let arrayOfCharacters = Array(name)
        var separatedSpace = " "
        for element in arrayOfCharacters {
            separatedSpace = separatedSpace + String(element) + " "
        }
        
        return separatedSpace
    }
    
}
