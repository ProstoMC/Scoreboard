//
//  ViewBase.swift
//
//
//  Created by admin on 26.07.24.
//

import Foundation
import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    
    var backgroundColor: Color
    var foregroundColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.width*0.12)
            .foregroundColor(
                configuration.isPressed ? foregroundColor.opacity(0.5) : foregroundColor)
            .background(configuration.isPressed ? backgroundColor.opacity(0.5) : backgroundColor)
            .cornerRadius(UIScreen.main.bounds.width*0.06)
        
    }
}

struct LineView: View {
    
    var width: CGFloat
    var height: CGFloat
    var color: Color
    var body: some View {
        color
            .frame(width: width, height: height)
            .cornerRadius(height/2)
    }
}
