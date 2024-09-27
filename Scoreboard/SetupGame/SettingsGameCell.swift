//
//  SettingsCell.swift
//  Scoreboard
//
//  Created by admin on 05.08.24.
//

import SwiftUI

import SwiftUI

struct SettingsGameCell: View {
    
    var name: String
    var systemImageName: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                HStack {
                    Image(systemName: systemImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(width: 50, height: 50)
                        .foregroundStyle(Color("accent"))
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        .padding(.leading, 12)
                    Spacer()
                    
                    Text(name)
                        .font(.subheadline)
                        .foregroundStyle(Color("accent"))
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 10)
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
    SettingsGameCell(name: "Name", systemImageName: "nosign")
        .preferredColorScheme(.dark)
}
