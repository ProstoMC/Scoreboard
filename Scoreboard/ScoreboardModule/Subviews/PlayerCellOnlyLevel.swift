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
    @State var animateGradient = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //USING ANIMATION WHEN CLOSE TO WIN
                if player.closeToWin {
                    LinearGradient(
                        colors: [playerColors[player.colorIndex].opacity(0.4), .winColor2, playerColors[player.colorIndex].opacity(0.4)],
                        startPoint: animateGradient ? .topLeading : .topTrailing,
                        endPoint: animateGradient ? .bottomTrailing : .topLeading
                    )
                    
                    // Animation to toggle the gradient colors
                    .onAppear {
                        withAnimation(.linear(duration: 4.0).repeatForever()) {
                            animateGradient.toggle()
                        }
                    }
                }
                else {
                    Color.background
                    playerColors[player.colorIndex].opacity(0.2)
                }
                
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
                        }, label: {
                            Image(systemName: "arrowshape.up.fill")
                                .foregroundStyle(.accent)
                        })
                        Text("\(player.level)")
                        Button(action: {
                            $player.level.wrappedValue = player.level - 1
                            withAnimation {
                                updateTrigger = true
                            }
                        }, label: {
                            Image(systemName: "arrowshape.down.fill")
                                .foregroundStyle(.accent)
                        }).padding(.trailing)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height/2))
            .shadow(color: .elements, radius: player.closeToWin ? 5 : 0)
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
    .preferredColorScheme(.dark)
}
