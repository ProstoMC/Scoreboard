//
//  SetupGame.swift
//  Scoreboard
//
//  Created by admin on 26.07.24.
//

import SwiftUI

struct SetupGameView: View {
    
    @Binding var viewModel: GameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {

                    TextField("New game", text: $viewModel.name)
                        .textFieldStyle(.plain)
                        .font(.title)
                        .foregroundStyle(Color.accent)
                        .multilineTextAlignment(.center)
                        .padding()

                    HStack { 
                        Button(action: {}, label: {
                            SettingsGameCell(name: "Max Level", systemImageName: "arrowshape.up")
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            SettingsGameCell(name: "Use Power", systemImageName: "bolt.fill")
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            SettingsGameCell(name: "Use Dice", systemImageName: "dice")
                        })
                        .frame(width: geometry.size.width*0.28, height: geometry.size.width*0.25/2)
                    }
                    .frame(width: geometry.size.width*0.9)
                    
                    LineView(width: geometry.size.width*0.9, height: 1, color: .elements)
                        .padding()
                    PlayersView(viewModel: viewModel)
                        .frame(width: geometry.size.width*0.9)
                    Spacer()
                }
            }
            
        }
    }
}

#Preview {
    SetupGameView(viewModel: Binding<GameViewModel>.constant(GameViewModel()))
        .preferredColorScheme(.light)
}


