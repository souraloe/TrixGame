//
//  TrixGameContentView.swift
//  TrixGame
//
//  Created by Vlad Ovcharov on 22.01.2021.
//

import SwiftUI

struct TrixGameContentView: View {
    @ObservedObject var viewModel = CardsViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Grid (viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .padding(5)
                    .aspectRatio(2/3, contentMode: .fit)
                }
                Button("New Game") {
                    withAnimation(.easeInOut) {
                        viewModel.startNewGame()
                    }
                }
            }
        }
    }
    
    //MARK: - default configs
    let backroundColor = Color(red: 81/255, green: 49/255, blue:105/255)
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 10).strokeBorder(card.chosed ? Color.blue : Color.black, lineWidth: 3).background(Color.white)
                GeometryReader { geometry in
                    body(for: geometry.size)
                }
            }
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        GeometryReader { geometry in
            VStack (alignment: .center) {
                Spacer()
                ForEach(0..<card.count) { index in
                    makeShape().padding(2).frame(
                        minWidth: 0,
                        maxWidth: geometry.size.width,
                        minHeight: 0,
                        maxHeight: geometry.size.height*0.3,
                        alignment: .center)
                }
                Spacer()
            }
        }
        .padding(5)
    }
    
    private func makeShape() -> some View {
        let group = Group {
            targetShape()
                .fill(card.color)
                .opacity(card.filling == Card.Filling.transparent ? 0.5 : 1)
        }
        .padding(3)
        
        return group
    }
    
    private func targetShape() -> some Shape {
        switch card.shape {
        case .ellipse: return AnyShape(Ellipse())
        case .diamond: return AnyShape(Diamond())
        case .rect: return AnyShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TrixGameContentView()
    }
}
