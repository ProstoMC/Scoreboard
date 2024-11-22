//
//  ScoreboardApp.swift
//  Scoreboard
//
//  Created by admin on 26.07.24.
//

import SwiftUI
import SwiftData

@main
struct ScoreboardApp: App {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault

    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .preferredColorScheme(userTheme.colorScheme)
        }
    }
    

}

