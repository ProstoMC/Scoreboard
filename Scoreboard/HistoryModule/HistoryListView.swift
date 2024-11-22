//
//  HistoryListView.swift
//  Scoreboard
//
//  Created by admin on 25.10.24.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel = HistoryVM()
    
    
    
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Color("background").ignoresSafeArea()
                VStack {
                    ScrollView {
                        ForEach($viewModel.games) { $game in
                            MainMenuCell(text: game.name, systemImageName: game.systemImageName)
                                .frame(width: geometry.size.width*0.9, height: 50)
                        }
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
