//
//  SwiftUIView.swift
//  Scoreboard
//
//  Created by sloniklm on 24.09.24.
//

import SwiftUI

struct ScoreboardView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ScoreboardVM()
    @State var shadowRadiusToWinCell: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("background").ignoresSafeArea()
                    VStack {
                        LineView(width: geometry.size.width, height: 1, color: .accent)
                        Spacer()
                        
                        //MARK: - PLAYERS
                        ScrollView {
                            ForEach($viewModel.players) { $player in
                                
                                if viewModel.stuffUsing {
                                    
                                    if player.closeToWin {
                                        PulseProtectorForCellView (
                                            useStuff: true,
                                            player: $player,
                                            updateTrigger: $viewModel.updateTrigger
                                            )
                                            .frame(height: 60)
                                            .padding(.horizontal)
                                            .onTapGesture {
                                                viewModel.showEditPlayerSubview(player: player)
                                            }
                                    }
                                    else {
                                        PlayerCellWithPower(player: $player, updateTrigger: $viewModel.updateTrigger)
                                            .frame(height: 70)
                                            .padding(.horizontal)
                                            .onTapGesture {
                                                viewModel.showEditPlayerSubview(player: player)
                                            }
                                    }
                                }
                                else {
                                    if player.closeToWin {
                                        PulseProtectorForCellView (
                                            useStuff: false,
                                            player: $player,
                                            updateTrigger: $viewModel.updateTrigger
                                            )
                                            .frame(height: 60)
                                            .padding(.horizontal)
                                            .onTapGesture {
                                                viewModel.showEditPlayerSubview(player: player)
                                            }
                                    }
                                    else {
                                        PlayerCellOnlyLevel (
                                            player: $player,
                                            updateTrigger: $viewModel.updateTrigger
                                            )
                                            .frame(height: 60)
                                            .padding(.horizontal)
                                            .onTapGesture {
                                                viewModel.showEditPlayerSubview(player: player)
                                            }
                                    }
                                    
                                    
                                }
                                
                            }.padding(.top)
                            
                            
                        }
                            Spacer()
                            
                            //MARK: - DICE BUTTON
                            
                            if viewModel.diceUsing {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        viewModel.showDiceSubview()
                                    }) {
                                        DiceButtonView()
                                            .frame(width: 60, height: 60)
                                            .padding()
                                            .shadow(color: .elements, radius: 3)
                                    }
                                }
                            }
                            
                            
                        }
                        //MARK: - SETUP NAVIGATION BAR
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            //Title
                            ToolbarItem(placement: .principal) {
                                Text(viewModel.gameName)
                                    .foregroundColor(.accent)
                                    .font(.title3)
                            }
                            //Back button
                            ToolbarItem(placement: .topBarLeading) {
                                Button(action: {
                                    viewModel.setGameState(state: .paused)
                                    dismiss()
                                }) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text("Back")
                                    }
                                }
                            }
                            //Max level
                            if viewModel.maxLevelUsing {
                                ToolbarItem(placement: .topBarTrailing) {
                                    Text("Level to win: \(viewModel.levelToWin)")
                                        .font(.subheadline)
                                }
                            }
                            
                        }
                    }
                }
                .tint(.accent)
                
                //MARK: - OPEN SUBVIEWS VIEW
                .sheet(isPresented: ($viewModel.showSubview), onDismiss: {
                    withAnimation{
                        viewModel.updateTrigger = true
                    }
                    viewModel.showSubview = false
                }) {
                    
                    if viewModel.typeOfSubview == .dice {
                        DiceThrowView(diceCount: viewModel.diceCount)
                            .presentationDetents([.height(geometry.size.height*0.35)])
                    } else {
                        EditPlayerView(player: $viewModel.editedPlayer, stuffUsing: viewModel.stuffUsing)
                            .presentationDetents([.height(geometry.size.height*0.35)])
                    }
                }
                
            }
        }
    }
    
    #Preview {
        ScoreboardView()
            .preferredColorScheme(.dark)
    }
    
    
    struct DiceButtonView: View {
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .foregroundStyle(.accent)
                    
                    Image(systemName: "dice.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                        .foregroundStyle(Color(.background))
                        .padding(.leading, geometry.size.width*0.05)
                        .padding(.top, geometry.size.height*0.05)
                }
            }
        }
    }
