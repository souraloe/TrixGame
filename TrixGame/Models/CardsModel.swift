//
//  CardsModel.swift
//  TrixGame
//
//  Created by Vlad Ovcharov on 22.01.2021.
//

import Foundation

struct CardsModel {
    private(set) var deck: Deck
    private(set) var showedCards: [Card] = []
    private(set) var cardsCountToShow = 0
    private(set) var scores = 0
    
    init(cardsCountToShow: Int, cardsSetFactory: () -> [Card]) {
        deck = Deck(deckFactory: cardsSetFactory)
        self.cardsCountToShow = cardsCountToShow
        showRequiredCards()
    }
    
    mutating func showNewCard() {
        guard let card = deck.popCard() else {
            return
        }
        showedCards.append(card)
    }
    
    mutating func select(card: Card) {
        if let selectedIndex = showedCards.firstIndex(matching: card) {
            if showedCards[selectedIndex].isSelected {
                showedCards[selectedIndex].isSelected = false
            } else {
                let selectedCardsCount = showedCards.filter { $0.isSelected }.count
                if selectedCardsCount < 3 {
                    showedCards[selectedIndex].isSelected = true
                }
            }
            let selectedCards = showedCards.filter { $0.isSelected }
            if selectedCards.count == 3 {
                if isMatch() {
                    scores += scoresForMatch
                    for selectedCard in selectedCards {
                        if let selectedCardIndex = showedCards.firstIndex(matching: selectedCard) {
                            showedCards.remove(at: selectedCardIndex)
                            if let newCard = deck.popCard() {
                                showedCards.insert(newCard, at: selectedCardIndex)
                            }
                        }
                    }
                }
            }
        }
    }
    
    mutating func showRequiredCards() {
        for _ in showedCards.count..<cardsCountToShow {
            showNewCard()
        }
    }
    
    private func isMatch() -> Bool {
        var isMatch = false
        let selectedCards = showedCards.filter { $0.isSelected }
        if selectedCards.count == 3 {
            isMatch = CardsModel.areSet(selectedCards[0].color, selectedCards[1].color, selectedCards[2].color) &&
                CardsModel.areSet(selectedCards[0].shape, selectedCards[1].shape, selectedCards[2].shape) &&
                CardsModel.areSet(selectedCards[0].filling, selectedCards[1].filling, selectedCards[2].filling) &&
                CardsModel.areSet(selectedCards[0].shapesCount, selectedCards[1].shapesCount, selectedCards[2].shapesCount)
            
            
        }
        return isMatch
    }
    
    private static func areSet<Feature: Hashable>(_ features: Feature...) -> Bool {
        return Set(features).count == features.count || Set(features).count == 1
    }
    
    //MARK: - constants
    private let scoresForMatch = 3
    private let scoresForDealNewCards = -1
}

struct Deck {
    private var cards: [Card]
    
    var remainingCardsCount: Int {
        cards.count
    }
    
    init(deckFactory: () -> [Card]) {
        cards = deckFactory()
    }
    
    mutating func popCard() -> Card? {
        guard !cards.isEmpty else {
            return nil
        }
        return cards.removeFirst()
    }
}
