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
    @State var closeToWinState: Bool = true
    @State var animateGradient: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("background").ignoresSafeArea()
                    VStack {
                        LineView(width: geometry.size.width, height: 1, color: .accent)
                        Spacer()
                        
                        //MARK: - INFO MODULE
                        if viewModel.maxLevelUsing {
                            HStack {
                                Text(viewModel.infoWinnerText)
                                    .font(.subheadline)
                                Spacer()
                                //MARK: - Show result view button
                                
                                if viewModel.gameState == .hasAWinner {
                                    Button(action: {
                                        viewModel.scoreButtonPressed()
                                    })
                                    {
                                        Text("🏆 S C O R E ")
                                            .font(.subheadline)
                                            .foregroundStyle(.accent)
                                            .frame(width: geometry.size.width/3.5, height: 30)
                                            .overlay(RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.accent))
                                    }
                                    
                                }
                            }
                            .padding(.top, 3)
                            .padding(.horizontal)
                            
                        }

                        //MARK: - PLAYERS
                        ScrollView {
                            ForEach($viewModel.players) { $player in
                                
                                if viewModel.stuffUsing {
                                    
                                    PlayerCellWithPower(player: $player, updateTrigger: $viewModel.updateTrigger)
                                        .frame(height: 70)
                                        .padding(.horizontal)
                                        .onTapGesture {
                                            viewModel.showEditPlayerSubview(player: player)
                                        }
                                }
                                else {
                                    PlayerCellOnlyLevel (player: $player, updateTrigger: $viewModel.updateTrigger)
                                        .frame(height: 60)
                                        .padding(.horizontal)
                                        .onTapGesture {
                                            viewModel.showEditPlayerSubview(player: player)
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
                                viewModel.gameState = .paused
                                viewModel.setGameStateToWorker()
                                dismiss()
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            
                            Button(action: {
                                viewModel.editButtonPressed()
                            }) {
                                HStack {
                                    Text("Edit")
                                    Image(systemName: "pencil")
                                }
                            }
                        }
                    }
                }
            }
            .tint(.accent)
            
            //MARK: - OPEN SUBVIEWS VIEW
            .sheet(isPresented: ($viewModel.showSubview), onDismiss: {
                
                //DISMISS PART
                
                if viewModel.typeOfSubview == .setupGame {
                    viewModel.getGameFromWorker()
                }
                
                //Manage levels Subview
                withAnimation {
                    viewModel.updateTrigger = true
                }
                viewModel.showSubview = false
                
                
                if viewModel.gameState == .finished {
                    viewModel.setGameStateToWorker()
                    dismiss()
                }
            }) {
                
                //OPEN PART
                
                switch viewModel.typeOfSubview {
                    
                case .dice:
                    DiceThrowView(diceCount: viewModel.diceCount)
                        .presentationDetents([.height(geometry.size.height*0.35)])
                    
                case .editPlayer:
                    EditPlayerView(player: $viewModel.editedPlayer, stuffUsing: viewModel.stuffUsing)
                        .presentationDetents([.height(geometry.size.height*0.35)])
                case .winner:
                    WinnerView(gameName: viewModel.gameName, players: viewModel.players, gameState: $viewModel.gameState)
                        .presentationDetents([.large])
                case .setupGame:
                    SetupGameView()
                        .presentationDetents([.large])
                    
                default:
                    DiceThrowView(diceCount: viewModel.diceCount)
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
