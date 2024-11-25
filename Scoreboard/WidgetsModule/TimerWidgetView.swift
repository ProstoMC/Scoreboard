//
//  TimerWidgetView.swift
//  Scoreboard
//
//  Created by admin on 22.11.24.
//

import SwiftUI

struct TimerWidgetView: View {
    @StateObject var viewModel = TimerVM()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let counter = 60
    let interval = 60
    
    @State var gradientpoint: CGFloat = 1
    
    func calcGradient() {
        gradientpoint = CGFloat(1 - Double(viewModel.counter)/Double(viewModel.interval+1))
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.background).ignoresSafeArea()
//                LinearGradient(stops: [
//                    Gradient.Stop(
//                        color: .background,
//                        location: gradientpoint),
//                    Gradient.Stop(
//                        color: .elements.opacity(0.5),
//                        location: gradientpoint+0.1),
//                ], startPoint: .top, endPoint: .bottom)
                //COUNT BUTTON
                VStack {
                    HStack {
                        Button(action: {
                            viewModel.showSubview = true
                        }) {
                            HStack {
                                Image(systemName: "timer")
                                    .foregroundStyle(.accent)
                                Text("T I M E R:  \(viewModel.returnText(seconds: viewModel.interval))")
                                    .font(.subheadline)
                                    .foregroundStyle(.accent)
                            }
                        }
                        Spacer()
                    }.padding()
                    Spacer()
                }
                
                VStack (spacing: geometry.size.height/10) {
                    Button(action: {
                        viewModel.buttonStartPressed()
                    })
                    {
                        HStack {
                            Image(systemName: viewModel.state == .inProgress ? "pause.circle" : "play.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.accent)
                            
                            Text("\(viewModel.timerText)")
                                .font(.system(size: 45)).monospaced()
                                .foregroundStyle(.accent)
                                .padding(.trailing, 10)
                                .onReceive(timer) { _ in
                                    if viewModel.state == .inProgress {
                                        viewModel.decrementCounter()
                                        withAnimation(.bouncy(duration: 1)) {
                                            calcGradient()
                                        }
                                        
                                    }
                                }
                        }
                        
                    }.padding(.top)
                    
                    Button(action: {
                        withAnimation {
                            viewModel.restartTimer()
                        }
                            
                    })
                    {
                        Image(systemName: "arrow.trianglehead.counterclockwise")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.accent)
                    }
                }.onChange(of: viewModel.interval, {
                    viewModel.resetTimer()
                })
            }
            //MARK: - SUBVIEWS
            .sheet(isPresented: $viewModel.showSubview) {
                IntervalPickerView(interval: $viewModel.interval, counter: $viewModel.counter)
                    .presentationDetents([.height(300)])
            }
        }
        
    }
}

#Preview {
    TimerWidgetView()
        .frame(height: UIScreen.main.bounds.height/2)
}
