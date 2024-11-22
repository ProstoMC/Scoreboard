//
//  ColorSchemeView.swift
//  Scoreboard
//
//  Created by admin on 20.11.24.
//

import SwiftUI

struct ColorSchemeView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    @State var bgColor = Color(#colorLiteral(red: 0.1442655921, green: 0.1564740241, blue: 0.2392717302, alpha: 1))
    @State var bgOpacity: Double = 1
     
    init() {
        makeBackground()
        changeBGOpacity()
    }
    
    func changeBGOpacity() {
        if userTheme == .systemDefault {
            bgOpacity = 1
        }
        else {
            bgOpacity = 0
        }
        
    }
    
    func makeBackground() {
        switch userTheme {
        case .light:
            bgColor = Color(#colorLiteral(red: 0.8728006482, green: 0.8905216455, blue: 0.8977711797, alpha: 1))
            
        case .dark:
            bgColor = Color(#colorLiteral(red: 0.1442655921, green: 0.1564740241, blue: 0.2392717302, alpha: 1))
            
        case .systemDefault:
            return
        }
    }
     
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                
                Color(.background).opacity(bgOpacity).ignoresSafeArea()
                Color(bgColor).opacity(1-bgOpacity).ignoresSafeArea()
                
                
                VStack {
                    
                    Spacer()
                    ForEach(Theme.allCases, id:\.rawValue) { theme in
                        
                        Button(action: {
                            userTheme = theme
                            
                            withAnimation(.easeIn(duration: 0.3)) {
                                changeBGOpacity()
                                makeBackground()
                            }
                        })
                        {
                            MainMenuCell(
                                text: theme.rawValue,
                                systemImageName: theme.systemImageName)
                            .frame(
                                width: geometry.size.width*0.6,
                                height: 50)
                            .padding(3)
                        }
                    }
                    
                    Spacer()
                }
            }
            
        }
        .tint(.accent)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("A P P   T H E M E")
                    .foregroundColor(.accent)
                    .font(.title3)
            }
        }.preferredColorScheme(userTheme.colorScheme)
    }
}

#Preview {
    ColorSchemeView()
        
}

enum Theme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case systemDefault = "System"
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .systemDefault: return nil
        }
    }
    
    var systemImageName: String {
        switch self {
        case .light: return "sun.max"
        case .dark: return "moon"
        case .systemDefault: return "gearshape"
        }
    }
    
    func returnAnimateColor() -> Color {
        switch self {
        case .light: return Color(#colorLiteral(red: 0.1442655921, green: 0.1564740241, blue: 0.2392717302, alpha: 1))
        case .dark: return Color(#colorLiteral(red: 0.8728006482, green: 0.8905216455, blue: 0.8977711797, alpha: 1))
        case .systemDefault: return Color(#colorLiteral(red: 0.1442655921, green: 0.1564740241, blue: 0.2392717302, alpha: 1))
        }
    }
}
