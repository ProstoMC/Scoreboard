//
//  MainMenuView.swift
//  Scoreboard
//
//  Created by admin on 23.09.24.
//

import SwiftUI

struct MainMenuView: View {
    
    @StateObject var viewModel = MainMenuVM()
    
    
    init(){
        //print("MainMenuView init. GameViewRquired: \(viewModel.shouldOpenGameView)")
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("background").ignoresSafeArea()
                    
                    VStack (spacing: 15) {
                        NavigationLink(destination: SetupGameView(appState: $viewModel.appState, gameWorker: viewModel.coreWorker.gameWorker)) {
                            MainMenuCell(
                                text: "Create game",
                                systemImageName: "dice")
                            .frame(
                                width: geometry.size.width*0.7,
                                height: 55)
                        }
                        NavigationLink(destination: SetupGameView(appState: $viewModel.appState, gameWorker: viewModel.coreWorker.gameWorker)) {
                            MainMenuCell(
                                text: "History",
                                systemImageName: "clock")
                            .frame(
                                width: geometry.size.width*0.6,
                                height: 40)
                        }
                        
                        NavigationLink(destination: AppSettingsView()) {
                            MainMenuCell(
                                text: "Settings",
                                systemImageName:"gear")
                            .frame(
                                width: geometry.size.width*0.5,
                                height: 40)
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
            
            //MARK: - OPEN GAME VIEW
            .fullScreenCover(isPresented: ($viewModel.shouldOpenGameView), onDismiss: {
                viewModel.shouldOpenGameView = false
            }) {
                ScoreboardView(appState: $viewModel.appState, gameWorker: viewModel.coreWorker.gameWorker)
            }
        }
    }
}

#Preview {
    MainMenuView()
        .preferredColorScheme(.light)
}
