//
//  HistoryListView.swift
//  Scoreboard
//
//  Created by admin on 25.10.24.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = HistoryVM()
    
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Color("background").ignoresSafeArea()
                VStack {
                    ScrollView {
                        ForEach($viewModel.games) { $game in
                            GameCell(game: game)
                                .frame(width: geometry.size.width*0.9, height: 60)
                                .onTapGesture {
                                    viewModel.gameCellTapped(game: game)
                                }
                        }
                    }
                    Button(action: {
                        viewModel.clearButtonPressed()
                    })
                    {
                        HStack {
                            Image(systemName: "eraser")
                                .foregroundStyle(.accent)
                            Text(" C L E A R")
                                .font(.subheadline)
                                .foregroundStyle(.accent)
                            
                        }
                        .frame(width: geometry.size.width/3.3, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.accent))
                        
                    }
                }
                //MARK: - OPEN SUBVIEWS VIEW
                .fullScreenCover(isPresented: ($viewModel.showGameReview), onDismiss: {
                    viewModel.showGameReview = false
                    if viewModel.shouldRestartGame {
                        viewModel.restartGame()
                        dismiss()
                    }
                }) {
                    ReviewGame(game: viewModel.chosenGame, shouldRestartFlag: $viewModel.shouldRestartGame)
                }
                .confirmationDialog("Plug", isPresented: $viewModel.showAcceptionAlert) {
                    Button("Clear history", role: .destructive) {
                        viewModel.clearHistory()
                    }
                }
            }
            .tint(.accent)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("H I S T O R Y")
                    .foregroundColor(.accent)
                    .font(.title3)
            }
        }
    }
}

#Preview {
    HistoryView()
}
