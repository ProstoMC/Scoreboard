//
//  EditPlayerView.swift
//  Scoreboard
//
//  Created by admin on 13.10.24.
//

import SwiftUI

struct EditPlayerView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var player: Player
    let stuffUsing: Bool
    
    @FocusState private var textFieldFocus: Bool

    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Color.background.ignoresSafeArea()
                playerColors[player.colorIndex].opacity(0.2).ignoresSafeArea()
                VStack {
                    LineView(width: geometry.size.width/8, height: 5, color: .elements)
                        .padding(.top)
                    
                    Text(player.name)
                        .font(.title2)
                        .foregroundStyle(Color.accent)
                        .padding(5)
                    
                    HStack(spacing: geometry.size.width/8) {
                        // MARK: - STUFF block
                        
                        if stuffUsing {
                            VStack {
                                
                                HStack {
                                    Image(systemName: "shield.righthalf.filled")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width / 15,
                                               height: geometry.size.width / 15)
                                        .foregroundStyle(.accent)
                                    Text("STUFF: ")
                                        .font(.title3)
                                        .lineLimit(1)
                                        .foregroundStyle(.accent)
                                    
                                }.padding()
                                
                                VStack {
                                    Button(action: {
                                        changeStuff(value: 1)
                                    },
                                           label: {
                                        Image(systemName: "arrowshape.up.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width / 15,
                                                   height: geometry.size.width / 15)
                                            .foregroundStyle(.accent)
                                    })
                                    
                                    TextField("0", value: $player.stuff, formatter: NumberFormatter())
                                        .focused($textFieldFocus)
                                        .keyboardType(.numberPad)
                                        .submitLabel(.done)
                                        .textFieldStyle(.plain)
                                        .font(.title)
                                        .foregroundStyle(Color.accent)
                                        .multilineTextAlignment(.center)

                                    Button(action: {
                                        changeStuff(value: -1)
                                    },
                                           label: {
                                        Image(systemName: "arrowshape.down.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.accent)
                                            .frame(width: geometry.size.width / 15,
                                                   height: geometry.size.width / 15)
                                            .foregroundStyle(.accent)
                                    })
                                }
                            }
                        }
                        
                        
                        // MARK: - LEVEL block
                        
                        VStack {
                            
                            HStack {
                                Image(systemName: "arrowshape.up")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width / 15,
                                           height: geometry.size.width / 15)
                                    .foregroundStyle(.accent)
                                Text("LEVEL: ")
                                    .font(.title3)
                                    .lineLimit(1)
                                    .foregroundStyle(.accent)
                                
                            }.padding()
                            
                            VStack {
                                Button(action: {
                                    changeLevel(value: 1)
                                },
                                       label: {
                                    Image(systemName: "arrowshape.up.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.accent)
                                        .frame(width: geometry.size.width / 15,
                                               height: geometry.size.width / 15)
                                        .foregroundStyle(.accent)
                                })
                                
                                TextField("0", value: $player.level, formatter: NumberFormatter())
                                    .focused($textFieldFocus)
                                    .keyboardType(.numberPad)
                                    .submitLabel(.done)
                                    .textFieldStyle(.plain)
                                    .font(.title)
                                    .foregroundStyle(Color.accent)
                                    .multilineTextAlignment(.center)
                                
                                Button(action: {
                                    changeLevel(value: -1)
                                },
                                       label: {
                                    Image(systemName: "arrowshape.down.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width / 15,
                                               height: geometry.size.width / 15)
                                        .foregroundStyle(.accent)
                                })
                            }
                        }
                    }
                    
                    Spacer() // For top alingment
                }
                .padding(.horizontal)
            }
            .onTapGesture {
                textFieldFocus = false
            }
        }
    }
    
    private func changeLevel(value: Int) {
        player.level += value
    }
    
    private func changeStuff(value: Int) {
        player.stuff += value
    }
}


#Preview {
    EditPlayerView(
        player: .constant(Player(name: "Player", level: 4, stuff: 2, colorIndex: 7)),
        stuffUsing: true
    )
    .frame(height: UIScreen.main.bounds.height / 2)
    .preferredColorScheme(.dark)
    
}
