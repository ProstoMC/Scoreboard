//
//  SettingsVIew.swift
//  Scoreboard
//
//  Created by admin on 23.09.24.
//

import SwiftUI

struct AppSettingsView: View {
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Color("background").ignoresSafeArea()
                VStack {
                    Text("S E T T I N G S")
                        .foregroundStyle(Color("accent"))
                        .font(.title3)
                        .padding(.top, 10)
                    Spacer()
                    VStack {
                        NavigationLink(destination: AppSettingsView()) {
                            MainMenuCell(
                                text: "Color scheme",
                                systemImageName: "circle.lefthalf.filled.righthalf.striped.horizontal")
                            .frame(
                                width: geometry.size.width*0.6,
                                height: 50)
                        }
                        NavigationLink(destination: AppSettingsView()) {
                            MainMenuCell(
                                text: "Clean history",
                                systemImageName: "eraser")
                            .frame(
                                width: geometry.size.width*0.6,
                                height: 50)
                        }
                        .padding(15)
                        NavigationLink(destination: AppSettingsView()) {
                            MainMenuCell(
                                text: "Remove ads",
                                systemImageName:"xmark.circle")
                            .frame(
                                width: geometry.size.width*0.6,
                                height: 50)
                        }
                    }
                    Spacer()
                }
            }
        }
        .tint(.accent)
    }
    
}
#Preview {
    AppSettingsView()
        .preferredColorScheme(.light)
}
