//
//  HistoryWorker.swift
//  Scoreboard
//
//  Created by admin on 29.10.24.
//

import Foundation
import Combine

class HistoryWorker {
    
    private var storedGames: [GameModel] = []
    
    var historyUpdated = PassthroughSubject<Bool, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        getGamesFromUserDefaults()
    }
    
    func returnStoredGames() -> [GameModel] {
        storedGames
    }
    
    func saveGameIfPossible(game: GameModel) {
        //Check if players stats was changed
        
        var shouldSave = false
        for player in game.players {
            if player.level != 0 || player.stuff != 0 {
                shouldSave = true
                break
            }
        }
        if shouldSave {
            storedGames.insert(game, at: 0)
            
            //Max 20 items
            if storedGames.count > 20 {
                storedGames.remove(at: storedGames.count-1)
            }
            print("=HISTORY UPDATED=")
            saveGamesToUserDefaults()
            historyUpdated.send(true)
        }
        
    }
    
    func returnLastGame() -> GameModel? {
        storedGames.first
    }
    func clearHistory() {
        storedGames = []
        saveGamesToUserDefaults()
    }
}


//MARK: - USER DEFAULTS
extension HistoryWorker {
    
    func saveGamesToUserDefaults() {
        print("--- SAVING GAMES: \(storedGames.count) ---")
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(storedGames) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "storedGames")
        }
    }
    
    func getGamesFromUserDefaults() {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "storedGames") as? Data {
            let decoder = JSONDecoder()
            if let storedGames = try? decoder.decode([GameModel].self, from: data) {
                self.storedGames = storedGames
                
            }
        }
    }
}
