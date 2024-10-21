//
//  PulseProtectorForCell.swift
//  Scoreboard
//
//  Created by admin on 16.10.24.
//

import SwiftUI

struct PulseProtectorForCellView: View {
    
    let useStuff: Bool
    @Binding var player: Player
    @Binding var updateTrigger: Bool
    @State var shadowRadius: CGFloat = 0.0
    
    var body: some View {
        if useStuff {
            PlayerCellWithPower(player: $player, updateTrigger: $updateTrigger)
                .shadow(color: .yellow ,radius: shadowRadius)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        shadowRadius = 5.0
                    }
                }
        }
        else {
            PlayerCellOnlyLevel(player: $player, updateTrigger: $updateTrigger)
                .shadow(color: .yellow ,radius: shadowRadius)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        shadowRadius = 5.0
                    }
                }
        }
        
        
    }
}

#Preview {
    PulseProtectorForCellView(useStuff: false, player: .constant(Player()), updateTrigger: .constant(false))
}
