//
//  SetupGame.swift
//  Scoreboard
//
//  Created by admin on 26.07.24.
//

import SwiftUI

struct SetupGameView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: SetupGameVM
    @FocusState private var nameTextFieldIsFocused: Bool
    @Binding var appState: AppState
    
    init(appState: Binding<AppState>, gameWorker: SetupGameProtocol) {
        //print("Initializing SetupGameView")
        self._appState = appState
        viewModel = SetupGameVM(gameWorker: gameWorker)
    }
    
    var body: some View {

        
        GeometryReader { geometry in
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    Image(systemName: viewModel.gameImageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.elements)
                        .frame(width: geometry.size.width/5, height: geometry.size.width/5)
                        .padding(.top)
                        
                    TextField("New game", text: $viewModel.gameName)
                        .focused($nameTextFieldIsFocused)
                        .onSubmit {
                            closeKeyboard()
                        }
                        .submitLabel(.done)
                        .frame(width: geometry.size.width/2)
                        .textFieldStyle(.plain)
                        .font(.title)
                        .foregroundStyle(Color.accent)
                        .multilineTextAlignment(.center)
                        .underlineTextField()
                        .padding()
                        
                    
                    //Traits panel
                    
                    HStack {
                        Button(action: {
                            closeKeyboard()
                            self.viewModel.toggleTrait(trait: "maxLevelUsing")
                            
                        }, label: {
                            SettingsGameCell(name: "Max Level", systemImageName: "arrowshape.up", isActive: $viewModel.maxLevelUsing)
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                        
                        Spacer()
                        
                        Button(action: {
                            closeKeyboard()
                            self.viewModel.toggleTrait(trait: "powerUsing")
                            
                        }, label: {
                            SettingsGameCell(name: "Use Power", systemImageName: "bolt.fill", isActive: $viewModel.powerUsing)
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                        
                        Spacer()
                        
                        Button(action: {
                            closeKeyboard()
                            self.viewModel.toggleTrait(trait: "diceUsing")
                            
                        }, label: {
                            SettingsGameCell(name: "Use Dice", systemImageName: "dice", isActive: $viewModel.diceUsing)
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                    }
                    .frame(width: geometry.size.width*0.9)
                    
                    LineView(width: geometry.size.width*0.9, height: 1, color: .elements)
                        .padding()
                    
                    //Players panel
                    
                    PlayersView(viewModel: viewModel)
                        .frame(
                            maxWidth: geometry.size.width*0.9,
                            minHeight: geometry.size.height*0.3
                        )
                        
                        
                        
                    
                    LineView(width: geometry.size.width*0.6, height: 1, color: .elements)
                        .padding()
                    
                    //Button start
                    
                    Button(action: {
                        if viewModel.gameState == .readyToStart {
                            appState = .gameStarting
                            viewModel.setGameToStart()
                            dismiss()
                        }
                        
                    }, label: {
                        if viewModel.gameState == .notReady {
                            PlayerTile(
                                name: "Start",
                                imageName: "play.circle"
                                )
                        } else {
                            PlayerTile(
                                name: "Start",
                                imageName: "play.circle",
                                color: .elements
                                )
                        }

                    }).frame(width: geometry.size.width/2.5, height: 60)
                    
                    //Button RESET
                    
                    Button(action: {
                        viewModel.resetGame()
                    }, label: {
                        Text("Reset")
                            .font(.subheadline)
                            .padding()
                            .foregroundStyle(.accent)
                    })
                    Spacer()
                    
                }
            }.onTapGesture {
                closeKeyboard()
            }
//            .onDisappear() {
//                if viewModel.gameState == .readyToStart {
//                    openGameViewAfterSetup = true
//                }
//                else {
//                    openGameViewAfterSetup = false
//                }
//            }
            
        }
    }
    
    private func closeKeyboard() {
        if nameTextFieldIsFocused {
            viewModel.setGameName()
        }
        nameTextFieldIsFocused = false
    }
    
    
}

#Preview {
    SetupGameView(appState: .constant(.noActiveGames), gameWorker: GameWorker())
        .preferredColorScheme(.light)
}


