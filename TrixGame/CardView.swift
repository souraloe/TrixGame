//
//  CardView.swift
//  TrixGame
//
//  Created by Vlad Ovcharov on 23.01.2021.
//

import SwiftUI

struct CardView: View {
    var card: Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    RoundedRectangle(cornerRadius: cardCornerRadius)
                        .strokeBorder(card.isSelected ? Color.blue : Color.black, lineWidth: card.isSelected ? cardStrokeWidth*1.5 : cardStrokeWidth)
                        .background(Color.white)
                    body(for: geometry.size)
                        .transition(.scale)
                }
            }
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        VStack (alignment: .center) {
            Spacer()
            ForEach(0..<card.shapesCount) { index in
                makeShape().padding(shapesPadding).frame(
                    minWidth: 0,
                    maxWidth: size.width,
                    minHeight: 0,
                    maxHeight: size.height*0.3,
                    alignment: .center)
            }
            Spacer()
        }
        .padding(cardPadding)
    }
    
    private func makeShape() -> some View {
        targetShape()
            .fill(card.color)
            .opacity(card.filling == Card.Filling.transparent ? 0.5 : 1)
            .padding(3)
    }
    
    private func targetShape() -> some Shape {
        var shape: AnyShape
        switch card.shape {
        case .ellipse: shape = AnyShape(Ellipse())
        case .diamond: shape = AnyShape(Diamond())
        case .rect: shape = AnyShape(RoundedRectangle(cornerRadius: 20))
        }
        return card.filling == Card.Filling.stroke ? AnyShape(shape.stroke(lineWidth: shapeStrokeWidth)) : shape
    }
    
    //MARK: - Drawing Constants
    
    private let cardCornerRadius: CGFloat = 10
    private let cardStrokeWidth: CGFloat = 3
    private let shapesPadding: CGFloat = 2
    private let cardPadding: CGFloat = 5
    private let shapeStrokeWidth: CGFloat = 4
}

