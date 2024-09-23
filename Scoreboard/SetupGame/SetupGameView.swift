//
//  SetupGame.swift
//  Scoreboard
//
//  Created by admin on 26.07.24.
//

import SwiftUI

struct SetupGameView: View {
    var gameType: GameType
    @State private var name: String
    @State private var subtitle: String
    
    init(gameType: GameType) {
        self.gameType = gameType
        self.name = gameType.name
        self.subtitle = gameType.subtitle
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
//                    HStack {
//                        Button(action: {}, label: {
//                            Text("Back")
//                                .font(.callout)
//                                .tint(.accent)
//                                .padding()
//                        })
//                        Spacer()
//                    }
                    Image(gameType.imageName ?? "Catan")
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height*0.2)
                    TextField("Name", text: $name)
                        .textFieldStyle(.plain)
                        .font(.title)
                        .foregroundStyle(Color.accent)
                        .multilineTextAlignment(.center)
                        .padding()
//                    TextField("Description", text: $subtitle)
//                        .textFieldStyle(.plain)
//                        .font(.subheadline)
//                        .foregroundStyle(Color.accent)
//                        .multilineTextAlignment(.center)
                    HStack {
                        Button(action: {}, label: {
                            SettingsCell(name: "Level ", systemImageName: "arrowshape.up")
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            SettingsCell(name: "Power", systemImageName: "bolt.fill")
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            SettingsCell(name: "Dice", systemImageName: "dice")
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                    }
                    .frame(width: geometry.size.width*0.9)
                    
                    LineView(width: geometry.size.width*0.9, height: 1, color: .elements)
                        .padding()
                    PlayersView()
                        .frame(width: geometry.size.width*0.9)
                    Spacer()
                }
            }
            
        }
    }
}

#Preview {
    SetupGameView(gameType: GameType(name: "Test Game", subtitle: "Description"))
        .preferredColorScheme(.dark)
}


