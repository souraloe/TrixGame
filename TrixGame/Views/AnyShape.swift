//
//  AnyShape.swift
//  TrixGame
//
//  Created by Vlad Ovcharov on 23.01.2021.
//

import SwiftUI

struct AnyShape: Shape {
    init<S: Shape>(_ wrapped: S) {
        pathGetter = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }
    
    func path(in rect: CGRect) -> Path {
        pathGetter(rect)
    }
    
    private let pathGetter: (CGRect) -> Path
}
