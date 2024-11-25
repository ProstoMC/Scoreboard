
//
//  TimerButtonView.swift
//  Scoreboard
//
//  Created by sloniklm on 11.11.24.
//

import SwiftUI

struct TimerButtonView: View {
    @StateObject var viewModel = TimerVM()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
               
                Button(action: {
                    //Actions handled in onTapGestrues
                }) {
                    HStack {
                        Image(systemName: viewModel.state == .paused ? "pause.circle" : "timer")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.accent)
                            
                            
                        if viewModel.state != .new {
                            Text("\(viewModel.timerShortText)")
                                .font(.title).monospaced()
                                .foregroundStyle(.accent)
                                .padding(.leading, geometry.size.height/10)
                                .onReceive(timer) { _ in
                                    if viewModel.state == .inProgress {
                                        viewModel.decrementCounter()
                                    }
                                    else {
                                        if viewModel.state == .finished {
                                            viewModel.decrementCloseTimer()
                                        }
                                    }
                                    
                                }
                        }
                        
                    }
                    .padding(geometry.size.height/5)
                    .overlay(RoundedRectangle(cornerRadius: geometry.size.height/2)
                        .stroke(Color.accent))
                    Spacer()
                    
                }
                
                .highPriorityGesture(TapGesture().onEnded{
                    withAnimation {
                        viewModel.buttonStartPressed()
                    }
                })
                .simultaneousGesture(LongPressGesture().onEnded { _ in
                    viewModel.showSubview = true
                })
                .onTapGesture(count: 2, perform: {
                    viewModel.showSubview = true
                })
                
                .onChange(of: viewModel.interval, {
                    withAnimation{
                        viewModel.resetTimer()
                    }
                    
                })
//MARK: - SUBVIEWS
                .sheet(isPresented: $viewModel.showSubview, onDismiss: {
                    withAnimation{
                        viewModel.resetTimer()
                    }
                }) {
                    IntervalPickerView(interval: $viewModel.interval, counter: $viewModel.counter)
                        .presentationDetents([.height(300)])
                }
                
                
            }
            
        }
        
        
    }
}

#Preview {
    TimerButtonView()
        .frame(height: 100)
}
