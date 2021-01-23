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
                    .padding(cardsPadding)
                    .aspectRatio(cardsAspectRatio, contentMode: .fit)
                }
                Button("New Game") {
                    withAnimation(.easeInOut) {
                        viewModel.startNewGame()
                    }
                }
            }
        }
    }
    
    //MARK: - Drawing Constants
    
    private let backroundColor = Color(red: 81/255, green: 49/255, blue:105/255)
    private let cardsPadding: CGFloat = 5
    private let cardsAspectRatio: CGFloat = 2/3
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TrixGameContentView()
    }
}
