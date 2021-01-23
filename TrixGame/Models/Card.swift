//
//  Card.swift
//  TrixGame
//
//  Created by Vlad Ovcharov on 22.01.2021.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    var id: Int
    var color: Color
    var shape: Shape
    var count: Int
    var filling: Filling
    var chosed: Bool = false
    
    enum Shape: CaseIterable {
        case ellipse
        case diamond
        case rect
    }
    
    enum Filling: CaseIterable {
        case stroke
        case transparent
        case filled
    }
}
