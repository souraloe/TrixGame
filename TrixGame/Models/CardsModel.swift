//
//  CardsModel.swift
//  TrixGame
//
//  Created by Vlad Ovcharov on 22.01.2021.
//

import Foundation

struct CardsModel {
    private(set) var cards: [Card]
    
    init(cardsSetFactory: () -> [Card]) {
        cards = cardsSetFactory()
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card) {
            if !cards[chosenIndex].chosed {
                cards[chosenIndex].chosed = true
            }
        }
    }
}
