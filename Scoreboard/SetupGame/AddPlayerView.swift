//
//  AddPlayerView.swift
//  Scoreboard
//
//  Created by admin on 26.09.24.
//

import SwiftUI

struct AddPlayerView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var player: Player
    @Binding var editIndex: Int? //If nil - create new Player
    @Binding var saveButtonPressed: Bool
    @Binding var deleteButtonPressed: Bool
    @FocusState private var textFieldFocus: Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Color.background.ignoresSafeArea()
                playerColors[player.colorIndex].opacity(0.2).ignoresSafeArea()
                VStack {
                    LineView(width: geometry.size.width/8, height: 5, color: .elements)
                        .padding(.top)
                    
                    
                    Text((editIndex == nil) ? "N e w   p l a y e r" : player.name)
                        .font(.title3)
                        .foregroundStyle(Color.accent)
                        .padding(5)
                    
                    //PLAYER NAME BLOCK
                    
                    HStack {
                        Text("P l a y e r   n a m e")
                            .frame(alignment: .leading)
                            .font(.subheadline)
                            .foregroundStyle(Color.accent)
                            .padding(.top)
                        Spacer()
                    }
                    
                    TextField("Player", text: $player.name)
                        .focused($textFieldFocus)
                        .frame(height: 14)
                        .foregroundColor(Color.accent)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.elements))
                        .padding(.bottom)
                    
                    //COLORS BLOCK
                    
                    VStack {
                        HStack (alignment: .center) {
                            LineView(width: geometry.size.width/3, height: 1, color: .elements)
                            Spacer()
                            Text("C o l o r")
                                .frame(alignment: .leading)
                                .font(.subheadline)
                                .foregroundStyle(Color.accent)
                            Spacer()
                            LineView(width: geometry.size.width/3, height: 1, color: .elements)
                        }.padding(5)
                        
                        LazyHGrid(
                            rows: [GridItem(.fixed(geometry.size.width/8)), GridItem(.fixed(geometry.size.width/8))],  alignment: .center, content: {
                                ForEach((0...playerColors.count-1), id: \.self) { index in
                                    
                                    //hightlite chosen circle
                                    if index != player.colorIndex {
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(playerColors[index])
                                            .frame(width: geometry.size.width/8, height: geometry.size.width/12)
                                            .padding(4)
                                            .overlay(Circle()
                                                .strokeBorder(Color.elements, lineWidth: 0.5)
                                            )
                                            .onTapGesture {
                                                
                                                $player.colorIndex.wrappedValue = index
                                            }
                                    }
                                    else {
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(playerColors[index])
                                            .frame(width: geometry.size.width/8, height: geometry.size.width/12)
                                            .padding(4)
                                            .overlay(Circle()
                                                .strokeBorder(Color.accent, lineWidth: 2)
                                            )
                                    }
                                    
                                }
                            })
                    }
                    
                    
                    Spacer()
                    
                    //BUTTONS BLOCK
                    
                    Button(action: {
                        saveButtonPressed = true
                        dismiss()
                    }) {
                        Text("S a v e")
                            .tint(.accent)
                            .font(.subheadline)
                            .frame(width: geometry.size.width/4, height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.elements))
                    }
                    if editIndex != nil {
                        Button(action: {
                            deleteButtonPressed = true
                            dismiss()
                        }) {
                            Text("Remove")
                                .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.1174641177, blue: 0.1611046791, alpha: 1)))
                                .font(.subheadline)
                                .padding()
                        }.padding()
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
            .onTapGesture {
                textFieldFocus = false
            }
        }
    }
}


#Preview {
    AddPlayerView(
        player: .constant(Player()),
        editIndex: .constant(nil),
        saveButtonPressed: .constant(false),
        deleteButtonPressed: .constant(false))
    .frame(height: UIScreen.main.bounds.height / 2)
    .preferredColorScheme(.dark)
    
}



