//
//  GameViewModel.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import Foundation

fileprivate enum PlayerState {
    case win
    case lose
    case drawn
    case next
}

final class GameViewModel {
    var scoreWasRefreshed: ((String,String)->Void)?
    var endTurnButtonStateChanged: ((Bool)->Void)?
    var playerGetNewCardToHisHand: (()->Void)?
    var opponentGetNewCardToHisHand: (()->Void)?
    var playerWinGame: ((Int,Int)->Void)?
    var playerLoseGame: ((Int,Int)->Void)?
    var playerDrawGame: ((Int)->Void)?
    var playerPointsChanged: ((Int)->Void)?
    var opponentPointsChanged: ((Int)->Void)?
    var playerWinsChanged: ((Int)->Void)?
    var opponentWinsChanged: ((Int)->Void)?
    var removeAllCardsFromPlayersHand: (()->Void)?
    var removeAllCardsFromOpponentsHand: (()->Void)?
    var opponentDecideToTakeOneMoreCard: (()->Void)?
    var opponentDecideToFinishTurn: (()->Void)?
    
    var opponentCards: [Card] = [] {
        didSet {
            if opponentCards.isEmpty {
                removeAllCardsFromOpponentsHand?()
            }
        }
    }
    var playerCards: [Card] = [] {
        didSet {
            if playerCards.isEmpty {
                removeAllCardsFromPlayersHand?()
            }
        }
    }
    
    private var deck = Deck()
    private var opponent: Opponent
    
    private var isOpponentFinishTurn = false
    private var isPlayerTurn = true
    private var isEndTurnButtonActive = true {
        didSet {
            endTurnButtonStateChanged?(isEndTurnButtonActive)
        }
    }
    private var playerWins = 0 {
        didSet {
            playerWinsChanged?(playerWins)
        }
    }
    private var opponentWins = 0 {
        didSet {
            opponentWinsChanged?(opponentWins)
        }
    }
    private var playerPoints = 0 {
        didSet {
            playerPointsChanged?(playerPoints)
        }
    }
    private var opponentPoints = 0 {
        didSet {
            opponentPointsChanged?(opponentPoints)
        }
    }
    
    init() {
        opponent = OpponentsFactory.chooseOneWishGrantAsOpponent() // TODO make reactivev with rx-Swift
        setupOpponentCallBacks()
    }
    
    func makeNewDraft() {
        playerPoints = 0
        opponentPoints = 0
        playerCards = []
        opponentCards = []
        isPlayerTurn = true
        isEndTurnButtonActive = true
        isOpponentFinishTurn = false
        deck.makeNewDraft()
    }
    
    func opponentFinishTurn() {
        let condition = checkForWinCondition()
        switch condition {
        case .win:
            opponentWins += 1
            playerLoseGame?(playerPoints, opponentPoints)
        case .lose:
            playerWins += 1
            playerWinGame?(playerPoints, opponentPoints)
        case .drawn:
            playerDrawGame?(playerPoints)
        default:
            break
        }
    }
    
    func refreshGameScore() {
        playerWins = 0
        opponentWins = 0
        makeNewDraft()
        scoreWasRefreshed?(opponent.name, opponent.image)
    }
    
    func endTurn() {
        if isPlayerTurn == true {
            isPlayerTurn = false
            isEndTurnButtonActive = false
            opponentDecideToTakeOneMoreCard?()
        } else {
            calculateWinConditionState()
        }
    }
    
    func giveCardToActivePlayer() {
        guard let card = deck.takeCardFromTop() else {
            return
        }
        if isPlayerTurn {
            playerCards.append(card)
            playerPoints = getPlayerPoints()
            playerGetNewCardToHisHand?()
            calculateWinConditionState()
        } else {
            opponentCards.append(card)
            opponentPoints = getOpponentPoints()
            opponentGetNewCardToHisHand?()
            opponent.getNewCardToMyHand()
        }
    }
}

//MARK: - Private functions
extension GameViewModel {
    private func setupOpponentCallBacks() {
        //Supply data
        opponent.whatIsMyScore = { [weak self] in
            self?.opponentWins ?? 0
        }
        opponent.whatIsPlayerScore = { [weak self] in
            self?.playerWins ?? 0
        }
        opponent.howManyPointsIHave = { [weak self] in
            self?.opponentPoints ?? 0
        }
        opponent.howManyPointsPlayerHave = { [weak self] in
            self?.playerPoints ?? 0
        }

        //Sending events
        opponent.takeOneMoreCard = { [weak self] in
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                self?.opponentDecideToTakeOneMoreCard?()
            }
        }
        opponent.finishThisTurn = { [weak self] in
            self?.isOpponentFinishTurn = true
            self?.opponentDecideToFinishTurn?()
        }
    }
    
    private func calculateWinConditionState() {
        let condition = checkForWinCondition()
        if isPlayerTurn {
            switch condition {
            case .win:
                playerWins += 1
                playerWinGame?(playerPoints, opponentPoints)
            case .lose:
                opponentWins += 1
                playerLoseGame?(playerPoints, opponentPoints)
            default: return
            }
        } else {
            switch condition {
            case .win:
                opponentWins += 1
                playerLoseGame?(playerPoints, opponentPoints)
            case .lose:
                playerWins += 1
                playerWinGame?(playerPoints, opponentPoints)
            default: return
            }
        }
    }
    
    private func getPlayerPoints() -> Int {
        return playerCards.reduce(0) { (sum, card) -> Int in
            sum + card.value.points()
        }
    }
    
    private func getOpponentPoints() -> Int {
        return opponentCards.reduce(0) { (sum, card) -> Int in
            sum + card.value.points()
        }
    }
    
    private func checkForWinCondition() -> PlayerState {
        if isPlayerTurn {
            let points = getPlayerPoints()
            if points == 21 {
                return .win
            } else if points > 21 {
                return .lose
            } else {
                return .next
            }
        } else {
            let points = getOpponentPoints()
            if isOpponentFinishTurn {
                if points == 21 {
                    return .win
                } else if points > 21 {
                    return .lose
                } else {
                    let playerPoints = getPlayerPoints()
                    if points > playerPoints {
                        return .win
                    } else if points == playerPoints {
                        return .drawn
                    } else {
                        return .lose
                    }
                }
            } else {
                if points == 21 {
                    return .win
                } else if points > 21 {
                    return .lose
                } else {
                    return .next
                }
            }
        }
    }
}

