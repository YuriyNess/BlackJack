//
//  Deck.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

enum Suits: String {
    case diamonds
    case hearts
    case spades
    case clubs
}

extension Suits {
    func getImageName() -> String {
        switch self {
        case .clubs:
            return "clubs"
        case .diamonds:
            return "rhombus"
        case .hearts:
            return "heart"
        case .spades:
            return "spade"
        }
    }
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
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case ace = "A"
}

struct Card {
    var suit: Suits
    var value: CardValues
}

final class Deck {
    private var cards: [Card] = []
    
    init() {
        makeNewDraft()
    }
    
    func takeCardFromTop() -> Card? {
        guard cards.count > 0 else { return nil }
        return cards.removeLast()
    }
    
    func makeNewDraft() {
        cards = loadCards()
        shuffle()
    }
    
    private func shuffle() {
        var arrWithRandValue = cards.map { (card) -> (Card, Int) in
            return (card, Int.random(in: 0...1000))
        }
        arrWithRandValue.sort { (first, second) -> Bool in
            first.1 < second.1
        }
        cards = arrWithRandValue.map({$0.0})
    }
    
    private func loadCards() -> [Card] {
        return [
            Card(suit: .diamonds, value: .two),Card(suit: .hearts, value: .two),Card(suit: .spades, value: .two),Card(suit: .clubs, value: .two),
            Card(suit: .diamonds, value: .three),Card(suit: .hearts, value: .three),Card(suit: .spades, value: .three),Card(suit: .clubs, value: .three),
            Card(suit: .diamonds, value: .four),Card(suit: .hearts, value: .four),Card(suit: .spades, value: .four),Card(suit: .clubs, value: .four),
            Card(suit: .diamonds, value: .five),Card(suit: .hearts, value: .five),Card(suit: .spades, value: .five),Card(suit: .clubs, value: .five),
            Card(suit: .diamonds, value: .six),Card(suit: .hearts, value: .six),Card(suit: .spades, value: .six),Card(suit: .clubs, value: .six),
            Card(suit: .diamonds, value: .seven),Card(suit: .hearts, value: .seven),Card(suit: .spades, value: .seven),Card(suit: .clubs, value: .seven),
            Card(suit: .diamonds, value: .eight),Card(suit: .hearts, value: .eight),Card(suit: .spades, value: .eight),Card(suit: .clubs, value: .eight),
            Card(suit: .diamonds, value: .nine),Card(suit: .hearts, value: .nine),Card(suit: .spades, value: .nine),Card(suit: .clubs, value: .nine),
            Card(suit: .diamonds, value: .ten),Card(suit: .hearts, value: .ten),Card(suit: .spades, value: .ten),Card(suit: .clubs, value: .ten),
            Card(suit: .diamonds, value: .jack),Card(suit: .hearts, value: .jack),Card(suit: .spades, value: .jack),Card(suit: .clubs, value: .jack),
            Card(suit: .diamonds, value: .queen),Card(suit: .hearts, value: .queen),Card(suit: .spades, value: .queen),Card(suit: .clubs, value: .queen),
            Card(suit: .diamonds, value: .king),Card(suit: .hearts, value: .king),Card(suit: .spades, value: .king),Card(suit: .clubs, value: .king),
            Card(suit: .diamonds, value: .ace),Card(suit: .hearts, value: .ace),Card(suit: .spades, value: .ace),Card(suit: .clubs, value: .ace),
        ]
    }
}
