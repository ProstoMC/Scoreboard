//
//  MainMenuView.swift
//  Scoreboard
//
//  Created by admin on 23.09.24.
//

import SwiftUI

struct MainMenuView: View {
    
    @StateObject var viewModel = MainMenuVM()
    
    @State private var pulseValue: CGFloat = 1.0
    @State private var coordinate: CGFloat = -100.0
    
    init() {
        print("Main menu init")
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("background").ignoresSafeArea()
                    
                    VStack {
                        if viewModel.showResumeGameView {
                            Button(action: {
                                viewModel.setGameState(state: .inProgress)
                                viewModel.openSubviewIfNeeded()
                            }, label: {
                                PulseCell(text: viewModel.currentGameName, systemImageName: "pause.circle", description: "paused")
                                    .frame(
                                        width: geometry.size.width * 0.5,
                                        height: 50)
                                    .padding()
                            })
                        }
                        Spacer()
                    }
                    
                    VStack (spacing: 15) {
                        //EDIT BUTTON

                        
                        Spacer()
                        
                        //  Create or edit button
                        
                        if viewModel.currenGameState == .paused || viewModel.currenGameState == .inProgress {
                            Button(action: {
                                viewModel.typeOfSubview = .setupGame
                                viewModel.showSubview = true
                            }) {
                                MainMenuCell(
                                    text: "Edit game", systemImageName: "dice")
                                .frame(
                                    width: geometry.size.width*0.7,
                                    height: 55)
                            }
                        }
                        else {
                            Button(action: {
                                viewModel.typeOfSubview = .setupGame
                                viewModel.showSubview = true
                            }) {
                                PulseCell(
                                    text: "Create new game", systemImageName: "dice")
                                .frame(
                                    width: geometry.size.width*0.7,
                                    height: 55)
                            }
                        }
                        
                        // History button
                        
//                        NavigationLink(destination: SetupGameView()) {
//                            MainMenuCell(
//                                text: "History",
//                                systemImageName: "clock")
//                            .frame(
//                                width: geometry.size.width*0.6,
//                                height: 40)
//                        }
                        
                        // Settings button
                        
                        NavigationLink(destination: AppSettingsView()) {
                            MainMenuCell(
                                text: "Settings",
                                systemImageName:"gear")
                            .frame(
                                width: geometry.size.width*0.5,
                                height: 40)
                        }
                        Spacer()
                        
                        
                    }
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            pulseValue = 3
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("S C O R E B O A R D")
                                .foregroundColor(.accent)
                                .font(.title3)
                        }
                    }
                }
            }
            .tint(.accent)
            
            //MARK: - OPEN SUBVIEWS VIEW
            .fullScreenCover(isPresented: ($viewModel.showSubview), onDismiss: {
                viewModel.showSubview = false
                viewModel.openSubviewIfNeeded()
            }) {
                switch viewModel.typeOfSubview {
                case .setupGame:
                    SetupGameView()
                case .scoreboard:
                    ScoreboardView()
                default:
                    ScoreboardView()
                }
                
            }
        }
    }
}

#Preview {
    MainMenuView()
        .preferredColorScheme(.light)
}
