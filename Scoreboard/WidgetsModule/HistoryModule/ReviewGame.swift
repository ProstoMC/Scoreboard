//
//  ReviewGame.swift
//  Scoreboard
//
//  Created by admin on 19.11.24.
//

import SwiftUI

struct ReviewGame: View {
    @Environment(\.dismiss) var dismiss
    
    var game: GameModel
    @Binding var shouldRestartFlag: Bool
    
    var gameName: String = ""
    
    init(game: GameModel, shouldRestartFlag: Binding<Bool>) {
        self.game = game
        self._shouldRestartFlag = shouldRestartFlag
        gameName = createNameWithSpacing(name: game.name)
    }
    
    private func createNameWithSpacing(name: String) -> String {
        let arrayOfCharacters = Array(name)
        var separatedSpace = " "
        for element in arrayOfCharacters {
            separatedSpace = separatedSpace + String(element) + " "
        }
        
        return separatedSpace.uppercased()
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.background.ignoresSafeArea()
                    
                    VStack(spacing: 15) {
                        
                        Text(gameName)
                            .font(.title2)
                            .foregroundStyle(.accent)
                        
                        HStack {
                            Text(game.date, format: .dateTime.day().month().year().hour().minute())
                                .foregroundStyle(.elements)
                        }
                        
                        HStack(spacing: 20) {
                            if game.levelToWin>0 {
                                Image(systemName: "arrowshape.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.accent)
                            }
                            if game.stuffUsing {
                                Image(systemName: "shield.lefthalf.filled")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.accent)
                            }
                            
                            if game.diceCount > 0 {
                                Image(systemName: "dice")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.accent)
                            }
                            
                        }
                        
                        Text("S C O R E")
                            .padding()
                            
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            //MARK: - Leader row
                            if game.players.count > 1 {
                                HStack {
                                    Text("🥇 \(game.players[0].name)")
                                        .foregroundStyle(.accent)
                                        .font(.title2)
                                    Spacer()
                                    Text("\(game.players[0].level)")
                                        .foregroundStyle(.accent)
                                        .font(.title2)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                            LineView(width: geometry.size.width/1.5, height: 1, color: .elements)
                            
                            //MARK: - Another players
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("🥈  \(game.players[1].name)")
                                        .foregroundStyle(.accent)
                                        .font(.headline)
                                    if game.players.count > 2 {
                                        Text("🥉  \(game.players[2].name)")
                                            .foregroundStyle(.accent)
                                            .font(.headline)
                                    }
                                    if game.players.count > 3 {
                                        ForEach (game.players.indices[3...], id: \.self) { index in
                                            Text("  \(index+1)   \(game.players[index].name)")
                                                .foregroundStyle(.elements)
                                                .font(.headline)
                                        }
                                    }
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 15) {
                                    Text("\(game.players[1].level)")
                                        .foregroundStyle(.accent)
                                        .font(.headline)
                                        .multilineTextAlignment(.trailing)
                                    if game.players.count > 2 {
                                        Text("\(game.players[2].level)")
                                            .foregroundStyle(.accent)
                                            .font(.headline)
                                            .multilineTextAlignment(.trailing)
                                    }
                                    if game.players.count > 3 {
                                        ForEach (game.players.indices[3...], id: \.self) { index in
                                            Text("\(game.players[index].level)")
                                                .foregroundStyle(.elements)
                                                .font(.headline)
                                                .multilineTextAlignment(.trailing)
                                        }
                                    }
                                }
                                
                            }
                        }
                        .frame(width: geometry.size.width*0.6)
                        .padding(.bottom)
                        
                        //BUTTONS BLOCK
                        
                        Button(action: {
                            shouldRestartFlag = true
                            dismiss()
                        }) {
                            Text("R E S T A R T")
                                .tint(.accent)
                                .font(.subheadline)
                                .frame(width: geometry.size.width/3, height: 50)
                                .overlay(RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.elements))
                                .padding()
                        }
                        
                        Spacer()
                    }
                    
                }
                .toolbar {
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
                }
            }
        }
    }
}

#Preview {
    ReviewGame(game: GameModel(name: "Test", stuffUsing: true, diceCount: 2, levelToWin: 4, players: [Player(), Player()]), shouldRestartFlag: .constant(false))
}
