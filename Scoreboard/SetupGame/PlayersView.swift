//
//  SwiftUIView.swift
//  Scoreboard
//
//  Created by admin on 07.08.24.
//

import SwiftUI

struct PlayersView: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    @State private var showingSheet = false
    @State private var editedPlayer: Player = Player()
    @State private var editIndex: Int? = nil //If nil - create new player
    @State private var saveButtonFlag: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Players")
                    .font(.title3)
                    .foregroundStyle(Color.accent)
                
                LazyVGrid(
                    columns: [GridItem(.fixed(geometry.size.width/2)), GridItem(.fixed(geometry.size.width/2))], alignment: .center, content: {
                        if viewModel.players.count > 0 {
                            ForEach((0...viewModel.players.count-1), id: \.self) { index in
                                PlayerTile(name: viewModel.players[index].name, imageName: "person.crop.circle.fill", color: playerColors[viewModel.players[index].colorIndex])
                                    .frame(width: geometry.size.width/2.1, height: geometry.size.width/5.5)
                                    .onTapGesture {
                                        editedPlayer = viewModel.players[index]
                                        editIndex = index
                                        showingSheet.toggle()
                                    }
                            }
                        }
                        PlayerTile(name: "Add new", imageName: "plus.circle")
                            .frame(width: geometry.size.width/2.1, height: geometry.size.width/5.5)
                            .onTapGesture {
                                editedPlayer = Player()
                                editIndex = nil
                                showingSheet.toggle()
                            }
                    })
                .sheet(isPresented: $showingSheet, onDismiss: {
                    if saveButtonFlag {
                        if editIndex == nil {
                            viewModel.addPlayer(newPlayer: editedPlayer)
                        }
                        else {
                            viewModel.players[editIndex!] = editedPlayer
                        }
                    }
                    saveButtonFlag = false
                    editedPlayer = Player()
                }) 
                {
                    AddPlayerView(player: self.$editedPlayer, editIndex: $editIndex, saveButtonPressed: $saveButtonFlag)
                        .presentationDetents([.medium])
                }
            }
        }
    }
}

#Preview {
    PlayersView(viewModel: GameViewModel())
        .preferredColorScheme(.light)
}




struct PlayerTile: View {
    
    var name: String
    var imageName: String
    var color: Color? = nil
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                HStack {
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(width: 50, height: 50)
                        .foregroundStyle(color ?? .accent)
                        .overlay(Circle()
                            .strokeBorder(Color.elements, lineWidth: 1)
                        )
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        .padding(.leading, 12)
                    Spacer()
                    
                    Text(name)
                        .font(.title3)
                        .foregroundStyle(Color("accent"))
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 12)
                    Spacer()
                    
                }
                .background(color.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: geometry.size.height/2))
                .overlay(
                    RoundedRectangle(cornerRadius: geometry.size.height/2)
                        .stroke(.elements, lineWidth: 1)
                    //.background(color.opacity(0.2))
                )
                
            }.padding(3)
        }
    }
    
}
