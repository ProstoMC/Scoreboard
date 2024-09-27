//
//  ContentView.swift
//  Scoreboard
//
//  Created by admin on 26.07.24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [GameType]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("background").ignoresSafeArea()
                    
                    VStack {
                        Text("S C O R E B O A R D")
                            .foregroundStyle(Color("accent"))
                            .font(.title3)
                            .padding(.top, 5)
                        HStack {
                            Spacer()
                            Button("My games", action: {
                                
                            })
                            .padding(.trailing, 20)
                            .foregroundStyle(Color.elements)
                        }
                        
                        Spacer()
                        
                        ScrollView(.vertical) {
                            Spacer().frame(height: geometry.size.height/2 - CGFloat(items.count*30))
                               
//                            ForEach(self.items) { item in
//                                NavigationLink(destination: SetupGameView()) {
//                                    MainMenuCell(text: item.name, systemImageName: "gear")
//                                        .frame(
//                                            width: UIScreen.main.bounds.width*0.8,
//                                            height: 50)
//                                }
//                            }
                            Spacer().frame(height: geometry.size.height/4)
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    VStack {
                        Spacer()
                        Button(action: {
                            addItem()
                        }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(15)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(Color("background"))
                                .background(Color("accent"))
                                .clipped()
                                .clipShape(Circle())
                        })
                    }
                    
                }
                
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = GameType(name: "Game", subtitle: "Description")
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
}

#Preview {
    MainView()
        .modelContainer(for: GameType.self, inMemory: true)
        .preferredColorScheme(.dark)
}
