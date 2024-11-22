//
//  DiceSetupView.swift
//  Scoreboard
//
//  Created by admin on 04.10.24.
//

import SwiftUI


//Updating values in .onAppear block of Body

struct DiceSetupView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var diceCount: Int
    
    @State var dicesChosen: [Bool] = [false, false ,false]
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    LineView(width: geometry.size.width/8, height: 5, color: .elements)
                        .padding(.top)
                    
                    Text("D I C E   S E T U P")
                        .font(.title3)
                        .foregroundStyle(Color.accent)
                        .padding()
                    
                    Spacer()
                    
                    //DICES BLOCK
                    
                    HStack (spacing: geometry.size.width/10) {
                        Image (systemName: ($dicesChosen.wrappedValue[0] ? "dice.fill" : "dice"))
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(dicesChosen[0] ? .accent : .elements)
                            .frame(width: geometry.size.width * 0.15, height: geometry.size.width/5)
                            .onTapGesture {
                                dicesChosen[0].toggle()
                            }
                        
                        Image (systemName: (dicesChosen[1] ? "dice.fill" : "dice"))
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(dicesChosen[1] ? .accent : .elements)
                            .frame(width: geometry.size.width * 0.15, height: geometry.size.width/5)
                            .onTapGesture {
                                dicesChosen[1].toggle()
                            }
                        
                        Image (systemName: (dicesChosen[2] ? "dice.fill" : "dice"))
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(dicesChosen[2] ? .accent : .elements)
                            .frame(width: geometry.size.width * 0.15, height: geometry.size.width/5)
                            .onTapGesture {
                                dicesChosen[2].toggle()
                            }
                    }
                    
                    Spacer()
                    
                    //BUTTONS BLOCK
                    
                    Button(action: {
                        calculateDices()
                        dismiss()
                    }) {
                        Text("S a v e")
                            .tint(.accent)
                            .font(.subheadline)
                            .frame(width: geometry.size.width/4, height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.elements))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .onAppear() {
                    updateDicesChosen()
                }
            }
        }
    }
    
    private func updateDicesChosen() {
        for i in 0...2 {
            if diceCount > i {
                dicesChosen[i] = true
            }
            else {
                dicesChosen[i] = false
            }
        }
    }
    
    private func calculateDices() {
        var count = 0
        for diceChoosen in dicesChosen {
            if diceChoosen {
                count += 1
            }
        }
        diceCount = count
    }
    
}

#Preview {
    DiceSetupView(diceCount: .constant(1))
        .frame(height: UIScreen.main.bounds.height/2)
}
