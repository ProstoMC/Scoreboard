//
//  MainMenuCell.swift
//  Scoreboard
//
//  Created by admin on 28.07.24.
//

import SwiftUI

struct MainMenuCell: View {
    
    var text: String
    var systemImageName: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                Text(text)
                    .font(.title3)
                    .foregroundStyle(Color("accent"))
                    .padding(.leading, geometry.size.height * 0.5)
                HStack {
                    Image(systemName: systemImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.height * 0.6,
                               height: geometry.size.height * 0.6)
                        .foregroundStyle(Color("accent"))
                        .padding(.leading, geometry.size.height*0.2)
                    Spacer()
                }
 
                
            }
            .padding(3)
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height/2))
            .overlay(
                RoundedRectangle(cornerRadius: geometry.size.height/2)
                    .stroke(.elements, lineWidth: 1)
            )
            
            
            
        }
    }
    
    
}

#Preview {
    MainMenuCell(text: "Test Game", systemImageName: "gear")
        .preferredColorScheme(.light)
        .frame(width: 250, height: 100)
}
