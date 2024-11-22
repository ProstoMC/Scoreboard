//
//  SwiftUIView.swift
//  Scoreboard
//
//  Created by admin on 05.10.24.
//

import SwiftUI

struct LevelSetupView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var level: Int
    @State private var levelField: String
    //    @State private var savePressed: Bool = false
    
    @FocusState private var focus: Bool
    
    init(level: Binding<Int>) {
        _level = level
        
        if level.wrappedValue == 0 {
            levelField = ""
        }
        else {
            levelField = String(level.wrappedValue)
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    LineView(width: geometry.size.width/8, height: 5, color: .elements)
                        .padding(.top)
                    
                    Text("L E V E L   S E T U P ")
                        .font(.title3)
                        .foregroundStyle(Color.accent)
                        .padding()
                    
                    Button(action: {
                        changeLevel(value: 1)
                    }, label: {
                        Image(systemName: "arrowshape.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.accent)
                    })
                    
                    HStack {
                        Spacer()
                        TextField("Unused", text: $levelField)
                            .focused($focus)
                            .keyboardType(.numberPad)
                            .submitLabel(.done)
                            .textFieldStyle(.plain)
                            .font(.title)
                            .foregroundStyle(Color.accent)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 18)
                        
                        Spacer()
                        if !levelField.isEmpty {
                            Button {
                                levelField = ""
                            }label: {
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.accent)
                                    .frame(width: 18, height: 18)
                            }
                            
                        }
                    }
                    .underlineTextField()
                    .frame(width: geometry.size.width/2)
                    
                    Button(action: {
                        changeLevel(value: -1)
                    }, label: {
                        Image(systemName: "arrowshape.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.accent)
                    })
                    .padding(.bottom)
                    
                    Spacer()
                    
                    //BUTTONS BLOCK
                    
                    Button(action: {
                        saveLevel()
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
            }
        }
        .onTapGesture {
            focus = false
        }
    }
    
    private func changeLevel(value: Int) {
        var newLevel = Int(levelField) ?? 0
        newLevel += value
        print("New level: \(newLevel)")
        if newLevel > 0 {
            levelField = String(newLevel)
        }
        else {
            levelField = ""
        }
    }
    
    private func saveLevel() {
        if let levelField = Int(levelField) {
            level = levelField
            return
        }
        if levelField.isEmpty {
            level = 0
        }
        
        
    }
}

#Preview {
    LevelSetupView(level: .constant(10))
        .frame(height: UIScreen.main.bounds.height / 3)
}
