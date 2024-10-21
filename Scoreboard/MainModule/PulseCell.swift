//
//  PulseCell.swift
//  Scoreboard
//
//  Created by admin on 06.10.24.
//


import SwiftUI

struct PulseCell: View {
    
    var text: String
    var systemImageName: String
    var description: String?
    @State var pulseLineWidth: CGFloat = 1.0
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                
                VStack {
                    Spacer()
                    Text(text)
                        .font(.title3)
                        .foregroundStyle(.accent)
                    
                    if description != nil {
                        LineView(
                            width: geometry.size.width/2,
                            height: 0.5,
                            color: .elements)
                        Text(description!)
                            .font(.subheadline)
                            .foregroundStyle(.accent)
                    }
                    Spacer()
                }.padding(.leading, geometry.size.height * 0.5)
                
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
                    .stroke(.elements, lineWidth: 0.5)
                    .stroke(Color(.accent).opacity(0.7), lineWidth: pulseLineWidth)
            )
            
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                pulseLineWidth = 3
            }
        }        
    }
    
}

#Preview {
    PulseCell(text: "Test Game", systemImageName: "gear")
        .preferredColorScheme(.light)
        .frame(width: 250, height: 100)
}
