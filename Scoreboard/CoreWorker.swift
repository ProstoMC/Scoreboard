//
//  CoreWorker.swift
//  Scoreboard
//
//  Created by admin on 27.09.24.
//

import Foundation
import Combine
import SwiftUI

class CoreWorker {
    @Environment(\.colorScheme) var systemScheme
    static let shared = CoreWorker()
    private var subscriptions = Set<AnyCancellable>()
    
    var gameWorker = GameWorker()
    var historyWorker = HistoryWorker()
    
    var colorScheme: ColorScheme = .light
        
    init() {
        //getColorSchemeFromDefalults()
        subscribe()
    }
    
    func createNewGame() {
        historyWorker.saveGameIfPossible(game: gameWorker.returnGame())
        gameWorker.resetGame()
    }
    
    //MARK: - COLOR SCHEME
    
//    private func getColorSchemeFromDefalults() {
//        let defaults = UserDefaults.standard
//        if let colorScheme = defaults.value(forKey: "colorScheme") as? ColorScheme {
//            self.colorScheme = colorScheme
//        } else {
//            self.colorScheme = systemScheme
//        }
//    }
    
    func setColorScheme(_ colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
        saveColorSchemeToUserDefaults()
    }
    func resetColorScheme() {
        self.colorScheme = systemScheme
        saveColorSchemeToUserDefaults()
    }
    
    func saveColorSchemeToUserDefaults() {

        let defaults = UserDefaults.standard
        defaults.set(colorScheme, forKey: "colorScheme")
        
    }
    
}

extension CoreWorker {
    private func subscribe() {
        gameWorker.gameSubject.sink { [weak self] game in
            if game.state == .finished {
                self?.saveGame(game: game)
            }
        }.store(in: &subscriptions)
    }
    
    private func saveGame(game: GameModel) {
        historyWorker.saveGameIfPossible(game: game)
        gameWorker.resetGame()
    }
}


