//
//  Cell.swift
//  Scoreboard
//
//  Created by admin on 19.11.24.
//

import SwiftUI

struct GameCell: View {
    
    var game: GameModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                
                HStack {
                    Image(systemName: game.systemImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.height * 0.6,
                               height: geometry.size.height * 0.6)
                        .foregroundStyle(Color("accent"))
                        .padding(.leading, geometry.size.height*0.2)
                        
                    Text(game.name)
                        .font(.title3)
                        .foregroundStyle(.accent)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        HStack{
                            Text("\(game.players.count) players")
                                .foregroundStyle(.elements)
                            Text("👤")
                                .font(.subheadline)
                        }
                        
                        HStack() {
                            Text(game.date, format: .dateTime.day().month().year())
                                .foregroundStyle(.elements)
                            Text("🕙")
                                .font(.subheadline)
                        }
                        
                    }
                    .padding(.trailing)
                }
            }
            .padding(3)
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height/2))
            .overlay(
                RoundedRectangle(cornerRadius: geometry.size.height/2)
                    .stroke(.elements, lineWidth: 0.5)
            )
        }
    }
}

#Preview {
    GameCell(game: GameModel(name:"Test", players: [Player(), Player()]))
        .preferredColorScheme(.light)
        .frame(height: 70)
}
