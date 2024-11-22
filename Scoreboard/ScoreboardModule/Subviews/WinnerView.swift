//
//  WinnerView.swift
//  Scoreboard
//
//  Created by admin on 22.10.24.
//

import SwiftUI

struct WinnerView: View {
    @Environment(\.dismiss) var dismiss
    
    let gameName: String
    @Binding var players: [Player]
    @Binding var gameState: GameState
    
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.background.ignoresSafeArea()
                    VStack(spacing: 15) {
                        
                        Text("C H A M P I O N S")
                            .font(.title3)
                            .padding(.bottom)
                        
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            //MARK: - Leader row
                            if players.count > 1 {
                                HStack {
                                    Text("🥇 \(players[0].name)")
                                        .foregroundStyle(.accent)
                                        .font(.title2)
                                    Spacer()
                                    Text("\(players[0].level)")
                                        .foregroundStyle(.accent)
                                        .font(.title2)
                                }
                            }
                            LineView(width: geometry.size.width/1.5, height: 1, color: .elements)
                            
                            //MARK: - Another players
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("🥈  \(players[1].name)")
                                        .foregroundStyle(.accent)
                                        .font(.headline)
                                    if players.count > 2 {
                                        Text("🥉  \(players[2].name)")
                                            .foregroundStyle(.accent)
                                            .font(.headline)
                                    }
                                    if players.count > 3 {
                                        ForEach (players.indices[3...], id: \.self) { index in
                                            Text("  \(index+1)   \(players[index].name)")
                                                .foregroundStyle(.elements)
                                                .font(.headline)
                                        }
                                    }
                                }
                                Spacer()
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("\(players[0].level)")
                                        .foregroundStyle(.accent)
                                        .font(.headline)
                                    if players.count > 2 {
                                        Text("\(players[1].level)")
                                            .foregroundStyle(.accent)
                                            .font(.headline)
                                    }
                                    if players.count > 3 {
                                        ForEach (players.indices[3...], id: \.self) { index in
                                            Text("\(players[index].level)")
                                                .foregroundStyle(.elements)
                                                .font(.headline)
                                        }
                                    }
                                }
                                
                            }
                        }
                        .frame(width: geometry.size.width*0.6)
                        .padding(.bottom)
                        
                        
                        //BUTTONS BLOCK
                        
                        Button(action: {
                            gameState = .finished
                            dismiss()
                        }) {
                            Text("Finish game")
                                .tint(.accent)
                                .font(.subheadline)
                                .frame(width: geometry.size.width/3, height: 50)
                                .overlay(RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.elements))
                        }
                        
                        Spacer()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        //Title
                        ToolbarItem(placement: .principal) {
                            Text(gameName)
                                .foregroundColor(.accent)
                                .font(.title3)
                        }
                        //Back button
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                gameState = .hasAWinner
                                dismiss()
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                            }
                        }
                    }
                }.tint(.accent)
            }
        }
    }
}


#Preview {
    WinnerView(gameName: "C S  2",
               players: .constant(
                [
                    Player(name: "Player 1768", colorIndex: 3, closeToWin: true),
                    Player(name: "Player 2", colorIndex: 6),
                    Player(name: "Random"),
                    Player(name: "Bot Rock")
                ]
               ),
               gameState: .constant(.empty)
    ).preferredColorScheme(.dark)
}
