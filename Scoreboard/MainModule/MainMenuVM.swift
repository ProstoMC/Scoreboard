//
//  MainMenuVM.swift
//  Scoreboard
//
//  Created by admin on 02.10.24.
//

import Foundation
import Combine
import SwiftData




class MainMenuVM: ObservableObject  {
    var modelContext: ModelContext?
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var showScoreboardView: Bool = false
    @Published var showSetupView: Bool = false
    @Published var typeOfSubview: Subviews = .scoreboard
    
    //@Published var currenGameState: GameState = .empty
    
    @Published var currentGameName: String = ""
    @Published var showResumeGameView: Bool = false
    @Published var resumeButtonWidthЬultiplier: CGFloat = 1.1
    
    init() {
        checkCurrentGame()
        subscribing()
    }
    
    

    //HISTORY AND SETTINGS ARE NAVIGATION LINKS
    func resumeButtonPressed() {
        setGameState(state: .inProgress)
        openSubviewIfNeeded()
    }
    
    func createGamePressed() {
        CoreWorker.shared.createNewGame()
        typeOfSubview = .setupGame
        showSetupView = true
    }
    
    func handleScoreboardViewClosing() {
        CoreWorker.shared.gameWorker.saveGameToUserDefaults()
    }
    
}

//MARK: - INTERNAL FUNCS

extension MainMenuVM {
    
    private func subscribing() {
        CoreWorker.shared.gameWorker.gameSubject.sink { [weak self] game in
            
            DispatchQueue.main.async {
                self?.updateRows(game: game)
                
                self?.openSubviewIfNeeded()
            }
        }.store(in: &subscriptions)
    }
    
    func setGameState(state: GameState) {
        //currenGameState = .inProgress //Forcing state for open after pause
        CoreWorker.shared.gameWorker.setGameState(gameState: state)
    }
    
    func clearCurrentGame() {
        CoreWorker.shared.gameWorker.resetGame()
    }
    

    func openSubviewIfNeeded() {
        if CoreWorker.shared.gameWorker.returnGameState() == .inProgress || CoreWorker.shared.gameWorker.returnGameState() == .edited {
            typeOfSubview = .scoreboard
            showScoreboardView = true
        }
    }
    
    func checkCurrentGame() {
        updateRows(game: CoreWorker.shared.gameWorker.returnGame())
    }
    
    private func updateRows(game: GameModel) {
        currentGameName = game.name
        
        if game.state == .paused || game.state == .inProgress {
            showResumeGameView = true
        }
        else {
            showResumeGameView = false
        }
    }
    

    
}


