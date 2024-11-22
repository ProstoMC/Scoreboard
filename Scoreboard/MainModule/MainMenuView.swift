//
//  MainMenuView.swift
//  Scoreboard
//
//  Created by admin on 23.09.24.
//

import SwiftUI
import SwiftData

struct MainMenuView: View {
    
    @StateObject private var viewModel = MainMenuVM()
    
    @State private var pulseValue: CGFloat = 1.0
    
    
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
                                viewModel.resumeButtonPressed()
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
                        Spacer()
                        //  Create button
                        
                        if viewModel.showResumeGameView {
                            Button(action: {
                                viewModel.createGamePressed()
                            }) {
                                MainMenuCell(
                                    text: "Create new game", systemImageName: "dice")
                                .frame(
                                    width: geometry.size.width*0.7,
                                    height: 55)
                            }
                        }
                        else {
                            Button(action: {
                                viewModel.createGamePressed()
                            }) {
                                PulseCell(
                                    text: "Create new game",
                                    systemImageName: "dice")
                                .frame(
                                    width: geometry.size.width*0.7,
                                    height: 55)
                            }
                        }
                        
                        NavigationLink(destination: WidgetsView()) {
                            MainMenuCell(
                                text: "Widgets",
                                systemImageName: "circle.grid.2x2")
                                .frame(
                                    width: geometry.size.width*0.65,
                                    height: 40)
                        }
                        
                        // History button
                        
                        NavigationLink(destination: HistoryView()) {
                            MainMenuCell(
                                text: "History",
                                systemImageName: "clock")
                            .frame(
                                width: geometry.size.width*0.575,
                                height: 40)
                        }
                        
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
                        Text("by sloniklm")
                            .font(.subheadline)
                            .foregroundStyle(.elements)
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
            
            //MARK: - OPEN SUBVIEWS
            .fullScreenCover(isPresented: $viewModel.showScoreboardView, onDismiss: {
                viewModel.showScoreboardView = false
                viewModel.handleScoreboardViewClosing()
                
            }) {
                ScoreboardView()
            }
            .fullScreenCover(isPresented: $viewModel.showSetupView, onDismiss: {
                viewModel.showSetupView = false
                viewModel.openSubviewIfNeeded()
            }) {
                SetupGameView()
            }
        }
        
    }
}

#Preview {
    MainMenuView()
        .preferredColorScheme(.light)
}
