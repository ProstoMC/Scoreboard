//
//  MainMenuVM.swift
//  Scoreboard
//
//  Created by admin on 02.10.24.
//

import Foundation
import Combine

class MainMenuVM: ObservableObject {
    var coreWorker = CoreWorker()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var shouldOpenGameView: Bool = false
    @Published var appState: AppState = .noActiveGames
    
    init() {
        subscribing()
    }
    
    private func subscribing() {
        $appState.sink { [weak self] appState in
            if appState == .gameStarting {
                self?.shouldOpenGameView = true
            }
            else {
                self?.shouldOpenGameView = false
            }
        }.store(in: &subscriptions)
    }

    
}


