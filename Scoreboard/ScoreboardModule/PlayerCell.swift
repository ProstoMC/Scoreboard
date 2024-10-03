//
//  PlayerCell.swift
//  Scoreboard
//
//  Created by admin on 25.09.24.
//

import SwiftUI

struct PlayerCell: View {
    
    
    @Binding var player: Player
    @Binding var levelChangedTrigger: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background

                HStack(spacing: 5) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.height * 0.6,
                               height: geometry.size.height * 0.6)
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
                                levelChangedTrigger = true
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
                                levelChangedTrigger = true
                            }
                        },
                               label: {
                            Image(systemName: "arrowshape.down.fill")
                                .foregroundStyle(.accent)
                        }).padding(.trailing)
                    }
                }
 
                
            }
            .padding(3)
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height/2))
            .overlay(
                RoundedRectangle(cornerRadius: geometry.size.height/2)
                    .stroke(.elements, lineWidth: 1)
            )
    
        }
    }
}


#Preview {

    PlayerCell(player: Binding<Player>.constant(Player(name: "Player", level: 2, power: 2)), levelChangedTrigger: .constant(false))
        .frame(width: UIScreen.main.bounds.width, height: 80)
}
