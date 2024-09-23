//
//  MainMenuCell.swift
//  Scoreboard
//
//  Created by admin on 28.07.24.
//

import SwiftUI

struct MainMenuCell: View {
    
    var gameType: GameType
    
    init(gameType: GameType) {
        self.gameType = gameType
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                HStack {
                    Image(systemName: "gamecontroller.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(width: 50, height: 50)
                        .foregroundStyle(Color("accent"))
                        .padding(12)
                    
                    VStack(alignment: .leading) {
                        Text(gameType.name)
                            .font(.headline)
                            .foregroundStyle(Color("accent"))
//                        Text("\(gameType.subtitle)")
//                            .font(.subheadline)
//                            .foregroundStyle(.black)
                    }
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: geometry.size.height/2))
                .overlay(
                    RoundedRectangle(cornerRadius: geometry.size.height/2)
                        .stroke(.elements, lineWidth: 1)
                    )
                
            }.padding(3)
            

            
        }
    }
        
        
}

#Preview {
    MainMenuCell(gameType: GameType(name: "Test Game", subtitle: "Description"))
        .preferredColorScheme(.dark)
}
