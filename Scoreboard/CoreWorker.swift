//
//  CoreWorker.swift
//  Scoreboard
//
//  Created by admin on 27.09.24.
//

import Foundation

class CoreWorker: ObservableObject {
    @Published var currentGame = GameViewModel()
}
