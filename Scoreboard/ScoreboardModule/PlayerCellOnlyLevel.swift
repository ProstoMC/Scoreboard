//
//  PlayerCell.swift
//  Scoreboard
//
//  Created by admin on 25.09.24.
//

import SwiftUI

struct PlayerCellOnlyLevel: View {
    
    
    @Binding var player: Player
    @Binding var updateTrigger: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                playerColors[player.colorIndex].opacity(0.2)
                HStack(spacing: 5) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.height * 0.5,
                               height: geometry.size.height * 0.5)
                        .foregroundStyle(playerColors[player.colorIndex])
                        .padding(.horizontal, geometry.size.height*0.2)
                    Text(player.name)
                        .font(.title3)
                        .foregroundStyle(Color("accent"))
                    Spacer()
                    // Levels buttons
                    HStack {
                        Button(action: {
                            $player.level.wrappedValue = player.level + 1
                            withAnimation { //Animation for reordering cells
                                updateTrigger = true
                            }
                        },
                               label: {
                            Image(systemName: "arrowshape.up.fill")
                                .foregroundStyle(.accent)
                        })
                        Text("\(player.level)")
                        Button(action: {
                            $player.level.wrappedValue = player.level - 1
                            withAnimation {
                                updateTrigger = true
                            }
                        },
                               label: {
                            Image(systemName: "arrowshape.down.fill")
                                .foregroundStyle(.accent)
                        }).padding(.trailing)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height/2))
            .overlay(
                RoundedRectangle(cornerRadius: geometry.size.height/2)
                    .stroke(.elements, lineWidth: 1)
            )
            

            
        }
    }
}


#Preview {
    
    PlayerCellOnlyLevel(player: Binding<Player>.constant(
        Player(
            name: "Player",
            level: 9,
            stuff: 2,
            closeToWin: true)
    ), updateTrigger: .constant(false))
        .frame(width: UIScreen.main.bounds.width*0.95, height: 80)
}
