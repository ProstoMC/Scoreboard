//
//  PlayerCell.swift
//  Scoreboard
//
//  Created by admin on 25.09.24.
//

import SwiftUI

struct PlayerCellWithPower: View {
    
    
    @Binding var player: Player
    @Binding var updateTrigger: Bool
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            let baseSize: CGFloat = {
                var baseSize: CGFloat = geometry.size.height/12
                
                if baseSize > geometry.size.width/50 {
                    baseSize = geometry.size.width/50
                }
                return baseSize
            }()
            
            ZStack {
                Color.background
                playerColors[player.colorIndex].opacity(0.2)
                HStack {
                    VStack (alignment: .leading) {
                        Text(player.name)
                            .font(Font.system(size: baseSize * 2.8))
                            .foregroundStyle(Color("accent"))
                        HStack {
                            Image(systemName: "bolt.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: baseSize * 3.2,
                                       height: baseSize * 3.2)
                                .foregroundStyle(playerColors[player.colorIndex])
                            Text("\(player.level+player.stuff)")
                                .font(Font.system(size: baseSize * 3.2))
                                .foregroundStyle(Color("accent"))
                        }
                    }.padding(.leading, baseSize * 2)
                    
                    Spacer()
                    
                    // MARK: - STUFF block
                    
                    VStack {
                        
                        HStack {
                            Image(systemName: "shield.righthalf.filled")
                                .resizable()
                                .scaledToFit()
                                .frame(width: baseSize * 2.3,
                                       height: baseSize * 2.3)
                            Text("Stuff: ")
                                .font(Font.system(size: baseSize * 2.5))
                        }
                        
                        HStack {
                            Button(action: {
                                $player.stuff.wrappedValue = player.stuff + 1
                                updateTrigger = true
                            },
                                   label: {
                                Image(systemName: "arrowshape.up.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: baseSize * 3,
                                           height: baseSize * 3)
                                    .foregroundStyle(.accent)
                            })
                            Text("\(player.stuff)")
                                .font(Font.system(size: baseSize * 2.8))
                            Button(action: {
                                $player.stuff.wrappedValue = player.stuff - 1
                                updateTrigger = true
                            },
                                   label: {
                                Image(systemName: "arrowshape.down.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: baseSize * 3,
                                           height: baseSize * 3)
                                    .foregroundStyle(.accent)
                            })
                        }
                    }.frame(width: geometry.size.width/4.5)
                        .padding(.horizontal, baseSize*2)
                    
                    // MARK: - LEVEL block
                    
                    VStack {
                        
                        HStack {
                            Image(systemName: "arrowshape.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: baseSize * 2.3,
                                       height: baseSize * 2.3)
                            Text("Level: ")
                                .font(Font.system(size: baseSize * 2.5))
                        }
                        
                        HStack {
                            Button(action: {
                                $player.level.wrappedValue = player.level + 1
                                withAnimation { //Animation for reordering cells
                                    updateTrigger = true
                                }
                            },
                                   label: {
                                Image(systemName: "arrowshape.up.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: baseSize * 3,
                                           height: baseSize * 3)
                                    .foregroundStyle(.accent)
                            })
                            Text("\(player.level)")
                                .font(Font.system(size: baseSize * 2.8))
                            Button(action: {
                                $player.level.wrappedValue = player.level - 1
                                withAnimation {
                                    updateTrigger = true
                                }
                            },
                                   label: {
                                Image(systemName: "arrowshape.down.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: baseSize * 3,
                                           height: baseSize * 3)
                                    .foregroundStyle(.accent)
                            })
                        }
                    }
                    .frame(width: geometry.size.width/4.5)
                    .padding(.trailing, baseSize * 2)
                }.padding(baseSize)
            }
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height/2))
            .overlay(
                RoundedRectangle(cornerRadius: geometry.size.height/2)
                    .stroke(.elements, lineWidth: 1)
            )
    
        }
    }
}


//#Preview {
//
//    PlayerCellWithPower(player: Binding<Player>.constant(Player(name: "Player", level: 2, stuff: 2)), levelChangedTrigger: .constant(false))
//        .frame(width: UIScreen.main.bounds.width*0.95, height: 80)
//}

#Preview {
    ScoreboardView()
}
