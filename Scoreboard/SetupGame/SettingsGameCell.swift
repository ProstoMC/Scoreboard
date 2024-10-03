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
    @Binding var isActive: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    Image(systemName: systemImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(width: 50, height: 50)
                        .foregroundStyle(isActive ? Color.background : Color.accent)
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        .padding(.leading, 12)
                    Spacer()
                    
                    Text(name)
                        .font(.subheadline)
                        .foregroundStyle(isActive ? Color.background : Color.accent)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 10)
                    Spacer()
                    
                }
                .background(isActive ? Color.elements : Color.background)
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
    SettingsGameCell(name: "Name", systemImageName: "nosign", isActive: .constant(true))
        .preferredColorScheme(.dark)
        .frame(height: 100)
}
