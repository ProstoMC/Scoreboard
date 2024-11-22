//
//  HistoryVM.swift
//  Scoreboard
//
//  Created by admin on 25.10.24.
//

import Foundation
import Combine

class HistoryVM: ObservableObject {
    
    private let historyWorker = CoreWorker.shared.historyWorker
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var games: [GameModel] = []
    @Published var shouldRestartGame: Bool = false
    var chosenGame: GameModel = GameModel()
    
    @Published var showGameReview: Bool = false
    @Published var showAcceptionAlert: Bool = false
    
    init() {
        fetchGames()
    }
    
    func clearButtonPressed() {
        showAcceptionAlert = true
    }
    
    func clearHistory() {
        historyWorker.clearHistory()
        fetchGames()
    }
    
    func gameCellTapped(game: GameModel) {
        chosenGame = game
        showGameReview = true
    }
    
    func restartGame() {
        CoreWorker.shared.gameWorker.createNewGameFromTemplate(template: chosenGame)
    }
    
}

extension HistoryVM {
    func fetchGames() {
        games = historyWorker.returnStoredGames()
    }
    
    func subscribe() {
        historyWorker.historyUpdated.sink { [weak self] flag in
            print("HISTORY UPDATED")
            DispatchQueue.main.async {
                self?.fetchGames()
            }
        }.store(in: &subscriptions)
    }
}
