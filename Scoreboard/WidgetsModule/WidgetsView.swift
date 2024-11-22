//
//  WidgetsView.swift
//  Scoreboard
//
//  Created by admin on 21.11.24.
//

import SwiftUI

struct WidgetsView: View {
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Color("background").ignoresSafeArea()
                VStack {
                    DiceWidgetView()
                        .frame(height: geometry.size.height/2.1)
                    LineView(width: geometry.size.width*0.95, height: 1, color: .accent)
                    DiceWidgetView()
                        .frame(height: geometry.size.height/2.1)
                }

            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("W I D G E T S")
                        .foregroundColor(.accent)
                        .font(.title3)
                }
            }
        }
    }
}

#Preview {
    WidgetsView()
}
