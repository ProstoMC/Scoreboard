//
//  SetupGame.swift
//  Scoreboard
//
//  Created by admin on 26.07.24.
//

import SwiftUI

struct SetupGameView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = SetupGameVM()
    @FocusState private var nameTextFieldIsFocused: Bool
    
    @State private var subviewIsShown: Bool = false
    @State private var saveButtonFlag: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.background.ignoresSafeArea()
                    VStack {
//                        Image(systemName: viewModel.gameImageName)
//                            .resizable()
//                            .scaledToFit()
//                            .foregroundStyle(.elements)
//                            .frame(width: geometry.size.width/6, height: geometry.size.width/6)
//                            .padding(.top)
                        
                        TextField("New game", text: $viewModel.gameName)
                            .focused($nameTextFieldIsFocused)
                            .onSubmit {
                                closeKeyboard()
                            }
                            .submitLabel(.done)
                            .frame(width: geometry.size.width/2)
                            .textFieldStyle(.plain)
                            .font(.title2)
                            .foregroundStyle(Color.accent)
                            .multilineTextAlignment(.center)
                            .underlineTextField()
                            .padding(.bottom)
                        //Traits panel
                        
                        HStack {
                            Button(action: {
                                closeKeyboard()
                                viewModel.setupViewType = "maxLevel"
                                subviewIsShown = true
                            }, label: {
                                SettingsGameCell(name: "Max Level", systemImageName: "arrowshape.up", isActive: $viewModel.maxLevelUsing)
                            })
                            .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                            
                            Spacer()
                            
                            Button(action: {
                                closeKeyboard()
                                self.viewModel.togglePowerUsing()
                                
                            }, label: {
                                SettingsGameCell(name: "Use Stuff", systemImageName: "shield.righthalf.filled", isActive: $viewModel.stuffUsing)
                            })
                            .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                            
                            Spacer()
                            
                            Button(action: {
                                closeKeyboard()
                                viewModel.setupViewType = "dice"
                                subviewIsShown = true
                                
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
                        
                       // LineView(width: geometry.size.width*0.6, height: 1, color: .elements)
                            
                        
                        //Button start
                        
                        Button(action: {
                            
                            if viewModel.readyToStart {
                                viewModel.setGameToStart()
                                dismiss()
                            }
                            
                        }, label: {
                            
                            switch viewModel.gameState {
                            case .new:
                                if viewModel.readyToStart {
                                    PulseCell(text: "Start", systemImageName: "play.circle")
                                }
                                else {
                                    MainMenuCell(text: "Start",systemImageName: "play.circle")
                                }
                            case .edited:
                                MainMenuCell(
                                    text: "Save",
                                    systemImageName: "tray.circle"
                                )
                            default:
                                MainMenuCell(
                                    text: "Start",
                                    systemImageName: "play.circle"
                                    )
                            }
                            
                        }).frame(width: geometry.size.width/2.8, height: 50)
                            .padding()
                    }
                }.onTapGesture {
                    closeKeyboard()
                }
                // MARK: - NAVIGATION BAR SETUP
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    //Title
                    ToolbarItem(placement: .principal) {
                        Text("S E T U P  G A M E")
                            .foregroundColor(.accent)
                            .font(.title3)
                    }
                    //Back button
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.accent)
                                Text("Back")
                                    .foregroundStyle(.accent)
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            viewModel.resetGame()
                        }) {
                            HStack {
                                Text("Reset")
                                    .foregroundStyle(.accent)
                                Image(systemName: "eraser")
                                    .foregroundStyle(.accent)
                            }
                        }
                    }
                }
                
                //MARK: - SUBVIEWS
                .sheet(isPresented: $subviewIsShown, onDismiss: {
                    viewModel.setTraitsButtons()
                }, content: {
                    if viewModel.setupViewType == "dice" {
                        DiceSetupView(diceCount: $viewModel.diceCount)
                            .presentationDetents([.medium])
                    }
                    else {
                        LevelSetupView(level: $viewModel.levelToWin)
                            .presentationDetents([.medium])
                    }
                })
            }

        }
    }
    
    //MARK: - FUNCTIONS
    
    private func closeKeyboard() {
        if nameTextFieldIsFocused {
            //viewModel.setGameName()
        }
        nameTextFieldIsFocused = false
    }
    
    
}

#Preview {
    SetupGameView()
        .preferredColorScheme(.light)
}


