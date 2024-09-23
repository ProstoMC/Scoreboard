//
//  GamePicker.swift
//  Scoreboard
//
//  Created by admin on 05.08.24.
//

import SwiftUI

struct GamePicker: View {
    
    
    @State var selection: Int = 1
    
    
    var body: some View {
        
        VStack {
            Text("\(selection)")
            Picker(
                selection: $selection,
                content: {
                    ForEach(0..<10) { number in
                        
                        if selection != number {
                            Text("\(number)").tag(number)
                        }
                        else {
                            Image(systemName: "plus").tag(number)
                        }
                        
                        
                        
                    }
            },
                label: {
                Text("Picker")
            })
            .pickerStyle(.wheel)
        }
    }
}

#Preview {
    GamePicker()
}
