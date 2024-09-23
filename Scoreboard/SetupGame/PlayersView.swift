//
//  SwiftUIView.swift
//  Scoreboard
//
//  Created by admin on 07.08.24.
//

import SwiftUI

struct PlayersView: View {

    var playersNames = ["Aleks", "Petya", "Sasha"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Players")
                    .font(.title3)
                    .foregroundStyle(Color.accent)
                
                LazyVGrid(
                    columns: [GridItem(.fixed(geometry.size.width/2)), GridItem(.fixed(geometry.size.width/2))], content: {
                    ForEach((0...playersNames.count-1), id: \.self) { index in
                        PlayerTile(name: playersNames[index], imageName: "person.crop.circle.fill")
                            .frame(width: geometry.size.width/2.1, height: geometry.size.width/5.5)
                            
                    }
                        PlayerTile(name: "Add new")
                            .frame(width: geometry.size.width/2.1, height: geometry.size.width/5.5)
                        
                })
            }
        }
    }
}

#Preview {
    PlayersView()
        .preferredColorScheme(.dark)
}


struct PlayerTile: View {
    var name: String
    var imageName: String?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                HStack {
                    Image(systemName: imageName ?? "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(width: 50, height: 50)
                        .foregroundStyle(Color("accent"))
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        .padding(.leading, 12)
                    Spacer()
                    
                    Text(name)
                        .font(.title3)
                        .foregroundStyle(Color("accent"))
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 12)
                    
                    
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
