//
//  CoreWorker.swift
//  Scoreboard
//
//  Created by admin on 27.09.24.
//

import Foundation
import Combine

class CoreWorker {
    static let shared = CoreWorker()
    
    var gameWorker = GameWorker()
}
