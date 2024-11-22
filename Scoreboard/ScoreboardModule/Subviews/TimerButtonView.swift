
//
//  TimerButtonView.swift
//  Scoreboard
//
//  Created by sloniklm on 11.11.24.
//

import SwiftUI

struct TimerButtonView: View {
    var timerTime: TimeInterval
    @State private var currentDate = Date.now
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(currentDate)")
            .onReceive(timer) { input in
                currentDate = input
            }
    }
}

#Preview {
    TimerButtonView(timerTime: 20)
}
