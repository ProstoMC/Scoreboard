//
//  MainMenuView.swift
//  Scoreboard
//
//  Created by admin on 23.09.24.
//

import SwiftUI
import SwiftData

struct MainMenuView: View {
    @EnvironmentObject var coreWorker: CoreWorker
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("background").ignoresSafeArea()
                    VStack {
                        Text("S C O R E B O A R D")
                            .foregroundStyle(Color("accent"))
                            .font(.title3)
                            .padding(.top, 10)
                        Spacer()
                        VStack {
                            NavigationLink(destination: SetupGameView(viewModel: $coreWorker.currentGame)) {
                                MainMenuCell(
                                    text: "Create game",
                                    systemImageName: "dice")
                                    .frame(
                                        width: geometry.size.width*0.7,
                                        height: 55)
                            }
                            NavigationLink(destination: SetupGameView(viewModel: $coreWorker.currentGame)) {
                                MainMenuCell(
                                    text: "History",
                                    systemImageName: "clock")
                                    .frame(
                                        width: geometry.size.width*0.6,
                                        height: 40)
                            }
                            .padding(15)
                            NavigationLink(destination: AppSettingsView()) {
                                MainMenuCell(
                                    text: "Settings",
                                    systemImageName:"gear")
                                    .frame(
                                        width: geometry.size.width*0.5,
                                        height: 40)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .tint(.accent)
        }
    }
}
    
    #Preview {
        MainMenuView()
            .preferredColorScheme(.light)
    }
