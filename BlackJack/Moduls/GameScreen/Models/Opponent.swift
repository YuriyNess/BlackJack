//
//  Opponent.swift
//  BlackJack
//
//  Created by YuriyFpc on 23.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

struct Opponent {
    var name: String
    var image: String
    var replicas: [String]
    
    //Ask for data
    var whatIsMyScore: (()->Int)!
    var whatIsPlayerScore: (()->Int)!
    var howManyPointsIHave: (()->Int)!
    var howManyPointsPlayerHave: (()->Int)!
    
    //Sending events
    var takeOneMoreCard: (()->Void)!
    var finishThisTurn: (()->Void)!
    
    func getNewCardToMyHand() {
        let myPoints = howManyPointsIHave()
        let playerPoints = howManyPointsPlayerHave()
        if myPoints < playerPoints {
            takeOneMoreCard()
        } else {
            finishThisTurn()
        }
    }
}

final class OpponentsFactory {
    static func chooseOneWishGrantAsOpponent() -> Opponent {
        return Opponent(name: "O.W.Grant", image: "", replicas: [
            "Nice try",
            "You almost win!",
            "Glad to be of service",
            "I don't quete follow you"
        ])
    }
}
