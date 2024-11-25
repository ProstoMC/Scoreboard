//
//  DiceWidgetView.swift
//  Scoreboard
//
//  Created by admin on 21.11.24.
//

import SwiftUI

struct DiceWidgetView: View {
    
    @State var diceCount: Int = 3
    @State var diceValues: [Int] = [0, 0, 0]
    
    @State var started = false
    @State private var showSubview = false
    
    @State private var sum = 0
    
    private func calcSum() {
        sum = 0
        for i in 0..<diceCount-1 { //Show result only after final setting
            if diceValues[i] == 0 {
                sum = 0
                return
            }
            sum += diceValues[i]
        }
    }
    
    func blinkToRestart() {
        //Reshow random dices on the screen for restarting it
        started = false
        diceValues = [0, 0, 0]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            started = true
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                Color("background").ignoresSafeArea()
                //COUNT BUTTON
                VStack {
                    HStack {
                        Button(action: {
                            showSubview = true
                        }) {
                            HStack {
                                Image(systemName: "dice")
                                    .foregroundStyle(.accent)
                                Text("C O U N T:  \(diceCount)")
                                    .font(.subheadline)
                                    .foregroundStyle(.accent)
                                
                            }
                        }
                        Spacer()
                    }.padding()
                    Spacer()
                }
                //Upper half of view
                VStack {
                    if !started {
                        HStack (spacing: geometry.size.width/10) {
                            ForEach (0 ..< diceCount, id: \.self) { _ in
                                Image(systemName: "dice")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        width: geometry.size.width / 5,
                                        height: geometry.size.width / 5
                                    )
                                    .onTapGesture {
                                        blinkToRestart()
                                    }
                            }
                        }.padding(.top, geometry.size.height*0.2)
                    }
                    else {
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
                                    radius: (sum == 0) ? 0 : 3
                                )
                                .onTapGesture {
                                    blinkToRestart()
                                }
                            }
                        }.padding(.top, geometry.size.height*0.2)
                    }
                    Spacer()
                }
                
                //Bottom half
                VStack() {
                    Spacer()
                    VStack {
                        Text("R E S U L T")
                            .foregroundStyle(.accent)
                            .padding(.bottom, 2)
                        Text((sum == 0) ? "-" : "\(sum)")
                            .foregroundStyle(.accent)
                            .font(.title3)
                    }
                    
                    Button(action: {
                        blinkToRestart()
                    }) {
                        HStack {
                            Text("R O L L")
                                .foregroundStyle(.accent)
                        }
                        .frame(width: geometry.size.width/3.2, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.accent))
                        .padding(.bottom)
                    }
                }
                
            }
            //SUBSCRIBE TO VALUES
            .onChange(of: diceValues, {
                calcSum()
            })
            //MARK: - SUBVIEWS
            .sheet(isPresented: $showSubview, onDismiss: {
                
            }, content: {
                DiceSetupView(diceCount: $diceCount)
                    .presentationDetents([.height(290)])
            })
            
        }
        
    }
    
}

#Preview {
    DiceWidgetView()
        .frame(height: UIScreen.main.bounds.height/2.3)
}
