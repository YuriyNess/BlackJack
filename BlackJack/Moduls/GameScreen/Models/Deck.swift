//
//  Deck.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import Foundation

enum Suits: String {
    case diamonds
    case hurts
    case spades
    case spears
}

enum CardValues: String {
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "Jack"
    case queen = "Queen"
    case king = "King"
    case ace = "Ace"
}

struct Card {
    var suit: Suits
    var value: CardValues
}

final class Deck {
    private var cards: [Card] = []
    
    
    init() {
        cards = loadCards()
    }
    
    func takeCardFromTop() -> Card {
        //TODO remove card from cards
        return Card(suit: .diamonds, value: .jack)
    }
    
    func makeNewDraft() {
        cards = loadCards()
        shuffle()
    }
    
    private func shuffle() {
        
    }
    
    private func loadCards() -> [Card] {
        return [
            Card(suit: .diamonds, value: .two),Card(suit: .hurts, value: .two),Card(suit: .spades, value: .two),Card(suit: .spears, value: .two),
            Card(suit: .diamonds, value: .three),Card(suit: .hurts, value: .three),Card(suit: .spades, value: .three),Card(suit: .spears, value: .three),
            Card(suit: .diamonds, value: .four),Card(suit: .hurts, value: .four),Card(suit: .spades, value: .four),Card(suit: .spears, value: .four),
            Card(suit: .diamonds, value: .five),Card(suit: .hurts, value: .five),Card(suit: .spades, value: .five),Card(suit: .spears, value: .five),
            Card(suit: .diamonds, value: .six),Card(suit: .hurts, value: .six),Card(suit: .spades, value: .six),Card(suit: .spears, value: .six),
            Card(suit: .diamonds, value: .seven),Card(suit: .hurts, value: .seven),Card(suit: .spades, value: .seven),Card(suit: .spears, value: .seven),
            Card(suit: .diamonds, value: .eight),Card(suit: .hurts, value: .eight),Card(suit: .spades, value: .eight),Card(suit: .spears, value: .eight),
            Card(suit: .diamonds, value: .nine),Card(suit: .hurts, value: .nine),Card(suit: .spades, value: .nine),Card(suit: .spears, value: .nine),
            Card(suit: .diamonds, value: .ten),Card(suit: .hurts, value: .ten),Card(suit: .spades, value: .ten),Card(suit: .spears, value: .ten),
            Card(suit: .diamonds, value: .jack),Card(suit: .hurts, value: .jack),Card(suit: .spades, value: .jack),Card(suit: .spears, value: .jack),
            Card(suit: .diamonds, value: .queen),Card(suit: .hurts, value: .queen),Card(suit: .spades, value: .queen),Card(suit: .spears, value: .queen),
            Card(suit: .diamonds, value: .king),Card(suit: .hurts, value: .king),Card(suit: .spades, value: .king),Card(suit: .spears, value: .king),
            Card(suit: .diamonds, value: .ace),Card(suit: .hurts, value: .ace),Card(suit: .spades, value: .ace),Card(suit: .spears, value: .ace),
        ]
    }
}
