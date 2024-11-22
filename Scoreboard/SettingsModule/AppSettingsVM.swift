//
//  AppSettingsVM.swift
//  Scoreboard
//
//  Created by admin on 20.11.24.
//

import Foundation

class AppSettingsVM: ObservableObject {
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown version"
        return "v\(version)"
    }
    
    @Published var showeEditShemeSubview = false
    @Published var clearHistoryAlert = false
    @Published var removeAdsSubview = false

    func clearHistory() {
        CoreWorker.shared.historyWorker.clearHistory()
    }
    
    
}
