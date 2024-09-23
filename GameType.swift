//
//  Item.swift
//  Scoreboard
//
//  Created by admin on 26.07.24.
//

import Foundation
import SwiftData

@Model
final class GameType {
    
    var name: String
    var subtitle: String
    var imageName: String?
    
    init(name: String, subtitle: String, imageName: String? = nil) {
        self.name = name
        self.subtitle = subtitle
        self.imageName = imageName
    }
}
