//
//  MainMenuVM.swift
//  Scoreboard
//
//  Created by admin on 02.10.24.
//

import Foundation
import Combine

class MainMenuVM: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var showSubview: Bool = false
    @Published var typeOfSubview: Subviews = .scoreboard
    
    @Published var currenGameState: GameState = .empty
    
    @Published var currentGameName: String = ""
    @Published var showResumeGameView: Bool = false
    @Published var resumeButtonWidthЬultiplier: CGFloat = 1.1
    
    init() {
        subscribing()
    }
    
    func setGameState(state: GameState) {
        currenGameState = .inProgress //Forcing state for open after pause
        CoreWorker.shared.gameWorker.setGameState(gameState: state)
    }
    
    func clearCurrentGame() {
        CoreWorker.shared.gameWorker.resetGame()
    }
    
    func openSubviewIfNeeded() {
        if currenGameState == .inProgress {
            typeOfSubview = .scoreboard
            showSubview = true
        }
    }
    
    private func subscribing() {
        CoreWorker.shared.gameWorker.gameSubject.sink { [weak self] game in
            
            DispatchQueue.main.async {
                self?.currentGameName = game.name
                self?.currenGameState = game.state
                
                //SETUP RESUME GAME
                if game.state == .paused  {
                    self?.showResumeGameView = true
                }
                else {
                    self?.showResumeGameView = false
                }
                
            }
        }.store(in: &subscriptions)
    }

    
}


