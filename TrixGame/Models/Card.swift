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
    var shapesCount: Int
    var filling: Filling
    var isSelected: Bool = false
    var state = State.none
    
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
    
    enum State {
        case none
        case matched
        case mismatched
    }
}
