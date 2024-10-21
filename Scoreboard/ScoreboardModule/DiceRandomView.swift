//
//  DiceRandomView.swift
//  Scoreboard
//
//  Created by admin on 08.10.24.
//

import SwiftUI

struct DiceRandomView: View {
    
    @Binding var value: Int // = Int.random(in: 1...6)
    @State var internalState: Int = 0
    @State var number = Int.random(in: 1...6)
    
    var throwCount: Int = 20 //Recomended 10...20
    @State var rollSpeed = 0.1 //Recomended 0.05...0.15
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                VStack {
                    switch number {
                    case 1:
                        DiceSheet1()
                            .padding(geometry.size.height * 0.15)
                    case 2:
                        DiceSheet2()
                            .padding(geometry.size.height * 0.15)
                    case 3:
                        DiceSheet3()
                            .padding(geometry.size.height * 0.15)
                    case 4:
                        DiceSheet4()
                            .padding(geometry.size.height * 0.15)
                    case 5:
                        DiceSheet5()
                            .padding(geometry.size.height * 0.15)
                    case 6:
                        DiceSheet6()
                            .padding(geometry.size.height * 0.15)
                    default:
                        DiceSheet1()
                            .padding(geometry.size.height * 0.15)
                    }
                    //                    Button(action: {
                    //                        number = Int.random(in: 1...6)
                    //                    }) {
                    //                        Text("R O L L")
                    //                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.height / 7))
            .overlay(RoundedRectangle(cornerRadius: geometry.size.height / 7)
                .stroke(.accent, lineWidth: geometry.size.height/20)
                     //                .shadow(
                     //                    color: .accent,
                     //                    radius: (internalState>=throwCount) ? geometry.size.height/10 : 0)
            )
        }
        //MARK: - ANIMATION
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + rollSpeed) {
                number = Int.random(in: 1...6)
                
                //Making changes slover in last 10 changes
                if internalState > (throwCount-5) {
                    rollSpeed += 0.1
                }
                
                //Refresh view for redrowing image
                if internalState < throwCount {
                    internalState += 1
                }
                else {
                    value = number
                }
                
            }
        }
        .id(internalState)
    }
    
}


#Preview {
    DiceRandomView(value: .constant(5), throwCount: 5)
        .frame(width: UIScreen.main.bounds.height/5, height: UIScreen.main.bounds.height/5)
    
}

//MARK: - SHEETS WITH DOTS

struct DiceSheet1: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let circleSize = geometry.size.height/4
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                    Spacer()
                }
                Spacer()
            }
            
        }
        
    }
}

struct DiceSheet2: View {
    
    var body: some View {
        GeometryReader { geometry in
            let circleSize = geometry.size.height/4
            VStack {
                HStack {
                    Spacer()
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                }
                Spacer()
                HStack {
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                    Spacer()
                }
            }
        }
    }
}

struct DiceSheet3: View {
    
    var body: some View {
        GeometryReader { geometry in
            let circleSize = geometry.size.height/4
            ZStack {
                Circle()
                    .fill(Color.accent)
                    .frame(width: circleSize, height: circleSize)
                VStack {
                    HStack {
                        Circle()
                            .fill(Color.accent)
                            .frame(width: circleSize, height: circleSize)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Circle()
                            .fill(Color.accent)
                            .frame(width: circleSize, height: circleSize)
                    }
                }
                
            }
        }
    }
}

struct DiceSheet4: View {
    
    var body: some View {
        GeometryReader { geometry in
            let circleSize = geometry.size.height/4
            VStack {
                HStack {
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                    Spacer()
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                }
                Spacer()
                HStack {
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                    Spacer()
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                }
            }
        }
    }
}

struct DiceSheet5: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let circleSize = geometry.size.height/4
                Circle()
                    .fill(Color.accent)
                    .frame(width: circleSize, height: circleSize)
                VStack {
                    HStack {
                        Circle()
                            .fill(Color.accent)
                            .frame(width: circleSize, height: circleSize)
                        Spacer()
                        Circle()
                            .fill(Color.accent)
                            .frame(width: circleSize, height: circleSize)
                    }
                    Spacer()
                    HStack {
                        Circle()
                            .fill(Color.accent)
                            .frame(width: circleSize, height: circleSize)
                        Spacer()
                        Circle()
                            .fill(Color.accent)
                            .frame(width: circleSize, height: circleSize)
                    }
                }
                
            }.transition(.scale.animation(.easeOut))
        }
    }
}




struct DiceSheet6: View {
    
    var body: some View {
        GeometryReader { geometry in
            let circleSize = geometry.size.height/4
            HStack {
                VStack {
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                    Spacer()
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                    Spacer()
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                }
                Spacer()
                VStack {
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                    Spacer()
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                    Spacer()
                    Circle()
                        .fill(Color.accent)
                        .frame(width: circleSize, height: circleSize)
                }
            }
        }
    }
}
