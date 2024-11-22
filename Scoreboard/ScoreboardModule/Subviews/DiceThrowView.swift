//
//  Untitled.swift
//  Scoreboard
//
//  Created by admin on 08.10.24.
//

import SwiftUI


struct DiceThrowView: View, Animatable {
    @Environment(\.dismiss) var dismiss
    @State var stateID: Int = 0
    
    var diceCount: Int
    @State var diceValues: [Int] = [0, 0, 0]
    
    var body: some View {
        
        let sum: Int = {
            var sum = 0
            
            for i in 0..<diceCount { //Show result only after final setting
                if diceValues[i] == 0 {
                    sum = 0
                    break
                }
                sum += diceValues[i]
            }
            return sum
        }()
        
        GeometryReader { geometry in
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    LineView(width: geometry.size.width/8, height: 5, color: .elements)
                        .padding(.top)
                    
                    ZStack {
                        VStack {
                            Text("R E S U L T")
                            Text((sum == 0) ? "-" : "\(sum)")
                        }
                        
                        HStack {
                            
                            Spacer()
                            Button(action: {
                                diceValues = [0, 0, 0]
                                stateID += 1
                            }) {
                                DiceButtonView()
                                    .frame(width: 50, height: 50)
                            }
                        }.padding()
                    }
                    
                    //DICES BLOCK
                    
                    HStack (spacing: geometry.size.width/10) {
                        ForEach (0 ..< diceCount, id: \.self) { index in
                            DiceRandomView(
                                value: $diceValues[index],
                                throwCount: Int.random(in: 10...15),
                                rollSpeed: Double.random(in: 0.05...0.15)
                            )
                            .frame(
                                width: geometry.size.width / 5,
                                height: geometry.size.width / 5
                            )
                            .shadow(
                                color: .elements,
                                radius: (sum == 0) ? 0 : 3)
                            
                        }
                    }
                    
                    Spacer()
                    
                    
                    

                    Spacer()
                }
                .padding(.horizontal)
                .onAppear() {
                    //
                }
            }
        }.id(stateID)
    }
    
    
}

#Preview {
    DiceThrowView(diceCount: 3)
        .frame(height: UIScreen.main.bounds.height/2)
}


