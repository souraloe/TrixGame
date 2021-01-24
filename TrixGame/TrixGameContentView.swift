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
                HStack {
                    Text("Trix")
                        .font(.title)
                    Spacer()
                    Text("Scores: \(viewModel.scores)")
                }
                .padding()
                Grid (viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation (.easeInOut(duration: 0.5)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(cardsPadding)
                    .aspectRatio(cardsAspectRatio, contentMode: .fit)
                    .transition(.offset(randomOffscreenOffset()))
                }
                HStack {
                    Button("New Game") {
                        withAnimation(.easeInOut(duration: 1)) {
                            viewModel.startNewGame()
                        }
                    }
                    .padding()
                    Spacer()
                    Button("Deal 3 More Cards") {
                        withAnimation(.easeInOut(duration: 1)) {
                            viewModel.dealMoreCards()
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    func randomOffscreenOffset() -> CGSize {
        let angle : Double = Double.random(in: 0..<(2 * Double.pi))
        return CGSize(width: offscreenRadius*cos(angle), height: offscreenRadius*sin(angle))
    }
    
    //MARK: - Drawing Constants
    
    private let backroundColor = Color(red: 81/255, green: 49/255, blue:105/255)
    private let cardsPadding: CGFloat = 5
    private let cardsAspectRatio: CGFloat = 2/3
    private let offscreenRadius : Double = 1000.0
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TrixGameContentView()
    }
}
