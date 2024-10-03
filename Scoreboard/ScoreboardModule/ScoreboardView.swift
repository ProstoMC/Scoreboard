//
//  SwiftUIView.swift
//  Scoreboard
//
//  Created by admin on 24.09.24.
//

import SwiftUI

struct ScoreboardView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: ScoreboardVM
    @Binding var appState: AppState
    
    
    init(appState: Binding<AppState>, gameWorker: ManageGameProtocol) {
        self._appState = appState
        viewModel = ScoreboardVM(gameWorker: gameWorker)
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("background").ignoresSafeArea()
                    VStack {
                        ForEach($viewModel.players) { $player in
                            PlayerCell(player: $player, levelChangedTrigger: $viewModel.levelsChanged)
                                .frame(height: 60)
                                .padding(.horizontal)
//                                .onTapGesture {
//                                    withAnimation { () -> () in
//                                        viewModel.players.remove(at: index)
//                                    }
//                                }
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
            
        }
    }
}

#Preview {
    ScoreboardView(appState: .constant(.gameStarting), gameWorker: GameWorker())
    
}
