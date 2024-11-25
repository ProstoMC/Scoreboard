//
//  IntervalPickerView.swift
//  Scoreboard
//
//  Created by admin on 25.11.24.
//

import SwiftUI

struct IntervalPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var interval: Int
    @Binding var counter: Int
    
    
    
    @State private var selectionSec: Int
    @State private var selectionMin: Int
    @State private var selectionHours: Int
    
    var seconds: Int { selectionSec % 60 }
    var minutes: Int { selectionMin % 60 }
    var hours: Int { selectionHours % 60 }
    
    enum ValueType {
        case hours
        case minutes
        case seconds
    }
    
    init (interval: Binding<Int>, counter: Binding<Int>) {
        self._interval = interval
        self._counter = counter
        
        let hours = interval.wrappedValue/3600
        let minutes = (interval.wrappedValue - hours*3600)/60
        let seconds = interval.wrappedValue - hours*3600 - minutes*60
        
        
        //300 - For endless wheel
        selectionHours = 300 + hours
        selectionMin = 300 + minutes
        selectionSec = 300 + seconds
        
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack {
                    HStack {
                        
                        VStack {
                            Text("H O U R S")
                                .font(.subheadline)
                                .foregroundStyle(.accent)
                            Picker(selection: $selectionHours, label: Text("HOURS")) {
                                ForEach(0 ..< 600) {
                                    Text(String(format: "%02d", $0 % 60))
                                        .font(.title2).monospaced()
                                        .foregroundStyle(.accent)
                                    
                                }
                            }.onChange(of: selectionHours) {
                                valueChanged(type: .hours, value: selectionHours)
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        VStack {
                            Text("M I N")
                                .font(.subheadline)
                                .foregroundStyle(.accent)
                            Picker(selection: $selectionMin, label: Text("Minutes:")) {
                                ForEach(0 ..< 600) {
                                    Text(String(format: "%02d", $0 % 60))
                                        .font(.title2).monospaced()
                                        .foregroundStyle(.accent)
                                    
                                }
                            }.onChange(of: selectionMin) {
                                valueChanged(type: .minutes, value: selectionMin)
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        VStack {
                            Text("S E C")
                                .font(.subheadline)
                                .foregroundStyle(.accent)
                            Picker(selection: $selectionSec, label: Text("Seconds:")) {
                                ForEach(0 ..< 600) {
                                    Text(String(format: "%02d", $0 % 60))
                                        .font(.title2).monospaced()
                                        .foregroundStyle(.accent)
                                    
                                }
                            }.onChange(of: selectionSec) {
                                valueChanged(type: .seconds, value: selectionSec)
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        
                    }
                    .padding()
                    .padding(.top)
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //Title
                ToolbarItem(placement: .principal) {
                    Text("T I M E R")
                        .foregroundColor(.accent)
                        .font(.title3)
                }
                //Back button
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.accent)
                            Text("Back")
                                .foregroundStyle(.accent)
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        counter = interval
                        dismiss()
                    }) {
                        HStack {
                            Text("Reset")
                                .foregroundStyle(.accent)
                            Image(systemName: "arrow.trianglehead.counterclockwise")
                                .foregroundStyle(.accent)
                        }
                    }
                }
            }
        }
        
    }
    
    func valueChanged(type: ValueType, value: Int) {
        
        switch type {
        case .seconds:
            selectionSec = 300 + value % 60
        case .minutes:
            selectionMin = 300 + value % 60
        case .hours:
            selectionHours = 300 + value % 60
        }
        
        interval = hours*3600 + minutes*60 + seconds
        
        
    }}

#Preview {
    IntervalPickerView(interval: .constant(6000), counter: .constant(60))
        .preferredColorScheme(.dark)
}
