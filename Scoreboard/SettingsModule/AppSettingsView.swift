//
//  SettingsVIew.swift
//  Scoreboard
//
//  Created by admin on 23.09.24.
//

import SwiftUI

struct AppSettingsView: View {
    
    @StateObject private var viewModel = AppSettingsVM()
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Color("background").ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack(spacing: 15) {
                        NavigationLink(destination: ColorSchemeView()) {
                            MainMenuCell(
                                text: "App Theme",
                                systemImageName: "circle.lefthalf.filled.righthalf.striped.horizontal")
                            .frame(
                                width: geometry.size.width*0.6,
                                height: 50)
                        }
                        
                            MainMenuCell(
                                text: "Clear History",
                                systemImageName: "eraser")
                            .frame(
                                width: geometry.size.width*0.6,
                                height: 50)
                            .onTapGesture {
                                viewModel.clearHistoryAlert = true
                            }
                        
                        NavigationLink(destination: AppSettingsView()) {
                            MainMenuCell(
                                text: "Remove Ads",
                                systemImageName:"xmark.circle")
                            .frame(
                                width: geometry.size.width*0.6,
                                height: 50)
                        }
                    }
                    Spacer()
                }
                //Bottom text on ZStack
                VStack {
                    Spacer()
                    Text(viewModel.appVersion)
                        .font(.subheadline)
                        .foregroundStyle(.elements)
                    Text("by sloniklm")
                        .font(.subheadline)
                        .foregroundStyle(.elements)
                }

            }
            .confirmationDialog("Plug", isPresented: $viewModel.clearHistoryAlert) {
                Button("Clear history", role: .destructive) {
                    viewModel.clearHistory()
                }
            }
            
        }
        .tint(.accent)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("S E T T I N G S")
                    .foregroundColor(.accent)
                    .font(.title3)
            }
        }
    }
    
    
}
#Preview {
    AppSettingsView()
        .preferredColorScheme(.light)
}
