//
//  SwiftUIView.swift
//  Scoreboard
//
//  Created by admin on 24.09.24.
//

import SwiftUI

struct ScoreboardView: View {
    
    @ObservedObject var viewModel = GameViewModel()
    
    init(game: GameModel) {
        viewModel.setupModelView(game: game)
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("background").ignoresSafeArea()
                    VStack {
                        Text(viewModel.name)
                            .foregroundStyle(Color("accent"))
                            .font(.title3)
                            .padding(.top, 10)
                        Text("\(viewModel.players[0].level)")
                        Spacer()
                        ForEach(self.viewModel.players.indices, id: \.self) { index in
                            PlayerCell(player: self.$viewModel.players[index])
                                .frame(height: 60)
                                .padding(.horizontal)
                        }
                        Spacer()
                    }
                }
            }
            .tint(.accent)
        }
    }
    

    
}

#Preview {
    ScoreboardView(game: GameModel(
        name: "Game",
        diceUsing: true,
        powerUsing: true,
        players: [Player(name: "Aleks", level: 2, power: 1),
                  Player(name: "Petya", level: 4, power: 9)],
        winner: nil))
}
