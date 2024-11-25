//
//  TimerVM.swift
//  Scoreboard
//
//  Created by admin on 24.11.24.
//

import Foundation
import SwiftUI

class TimerVM: ObservableObject {
    @Published var closeTimer = 30
    
    @Published var interval: Int = 60 //Default interval for most games
    @Published var counter: Int = 30
    @Published var state: GameState = .new

    @Published var timerText: String = ""
    @Published var timerShortText: String = ""
    
    @Published var showSubview = false
    
    init() {
        counter = interval
        timerText = returnText(seconds: interval)
        timerShortText = returnShortText(seconds: interval)
    }
    
    func decrementCloseTimer() {
        closeTimer -= 1
        if closeTimer == 0 {
            withAnimation {
                
                state = .new
                closeTimer = 30
            }
            
        }
    }

    
    func decrementCounter() {
        counter -= 1
        timerText = returnText(seconds: counter)
        timerShortText = returnShortText(seconds: counter)
        if counter == 0 {
            withAnimation {
                state = .finished
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                if self != nil {
                    self!.counter = self!.interval
                    withAnimation {
                        self!.timerText = self!.returnText(seconds: self!.counter)
                        self!.timerShortText = self!.returnShortText(seconds: self!.counter)
                    }
                    
                }
                
            }
        }
    }
    
    
    func buttonStartPressed() {
        if counter == 0 {
            counter = interval
            timerText = returnText(seconds: counter)
            timerShortText = returnShortText(seconds: counter)
        }
        
        if state == .inProgress {
            state = .paused
        }
        else {
            self.state = .inProgress
        }
            
    }
    
    func restartTimer() {
        state = .new
        counter = interval
        timerText = returnText(seconds: counter)
        timerShortText = returnShortText(seconds: counter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.state = .inProgress
        }
    }
    func resetTimer() {
        state = .finished
        counter = interval
        timerText = returnText(seconds: counter)
        timerShortText = returnShortText(seconds: counter)
    }
    
}

extension TimerVM {
    func returnText(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds - hours * 3600) / 60
        
        let secondsStr = String(format: "%02d", (seconds - hours * 3600 - minutes * 60))
        let minutesStr = String(format: "%02d", minutes)
        let hoursStr = String(format: "%02d", hours)

        return "\(hoursStr):\(minutesStr):\(secondsStr)"
    }
    
    func returnShortText(seconds: Int) -> String {
        
        if interval <= 60 {
            return String(format: "%02d", seconds)
        }
        
        if interval > 60 && interval <= 3600 {
            let minutes = String(format: "%02d", seconds / 60)
            let seconds = String(format: "%02d", seconds % 60)
            return "\(minutes):\(seconds)"
        }
        
        
        return returnText(seconds: seconds)
    }
}
