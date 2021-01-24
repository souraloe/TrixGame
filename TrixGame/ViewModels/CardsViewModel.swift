//
//  CardsViewModel.swift
//  TrixGame
//
//  Created by Vlad Ovcharov on 22.01.2021.
//

import SwiftUI

class CardsViewModel: ObservableObject {
    @Published private(set) var model: CardsModel
    
    private static let visibleCardsCount = 12
    
    internal init() {
        self.model = CardsViewModel.createCardsModel()
    }
    
    func startNewGame() {
        self.model = CardsViewModel.createCardsModel()
    }
    
    func dealMoreCards() {
        for _ in 0...2 {
            model.showNewCard()
        }
    }
    
    static private func createCardsModel() -> CardsModel {
        return CardsModel (cardsCountToShow: visibleCardsCount) {
            var cards: [Card] = []
            var currentId = 0
            let defaultColors = [Color(red:204/255, green:73/255, blue:71/255),
                                 Color(red:57/255, green:48/255, blue:116/255),
                                 Color(red:74/255, green:163/255, blue:94/255)]
            for shape in Card.Shape.allCases {
                for filling in Card.Filling.allCases {
                    for color in defaultColors {
                        for shapesCount in 1...3 {
                            cards.append(Card(
                                id: currentId,
                                color: color,
                                shape: shape,
                                shapesCount: shapesCount,
                                filling: filling
                            ))
                            currentId += 1
                        }
                    }
                }
            }
            cards.shuffle()
            return cards
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: [Card] {
        model.showedCards
    }
    
    var scores: Int {
        model.scores
    }
    
    //MARK: - Intent(s)
    
    func choose(card: Card) {
        objectWillChange.send()
        model.select(card: card)
    }
}
