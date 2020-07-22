//
//  GameViewModel.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

fileprivate enum PlayerState {
    case win
    case lose
    case next
}

final class GameViewModel {
    var scoreWasRefreshed: (()->Void)?
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
    
    func opponentFinishTurn() {
        if playerPoints > opponentPoints {
            playerWins += 1
            playerWinGame?(playerPoints, opponentPoints)
            prepareModelForNewDraft()
        } else if playerPoints < opponentPoints {
            opponentWins += 1
            playerLoseGame?(playerPoints, opponentPoints)
            prepareModelForNewDraft()
        } else {
            playerDrawGame?(playerPoints)
            prepareModelForNewDraft()
        }
    }
    
    func refreshGameScore() {
        playerWins = 0
        opponentWins = 0
        prepareModelForNewDraft()
        scoreWasRefreshed?()
    }
    
    private func prepareModelForNewDraft() {
        playerPoints = 0
        opponentPoints = 0
        playerCards = []
        opponentCards = []
        isPlayerTurn = true
        isEndTurnButtonActive = true
        deck.makeNewDraft()
    }
    
    func chagePlayer() {
        isPlayerTurn = !isPlayerTurn
        //testing TODO - remove
        if isPlayerTurn == true {
            opponentFinishTurn()
        }
        //--
        isEndTurnButtonActive = !isEndTurnButtonActive
    }
    
    func giveCardToActivePlayer() {
        guard let card = deck.takeCardFromTop() else {
            return
        }
        if isPlayerTurn {
            playerCards.append(card)
            playerPoints = getPlayerPoints()
            playerGetNewCardToHisHand?()
        } else {
            opponentCards.append(card)
            opponentPoints = getOpponentPoints()
            opponentGetNewCardToHisHand?()
        }
        
        calculateWinConditionState()
    }
    
    private func calculateWinConditionState() {
        let condition = checkForWinCondition()
        if isPlayerTurn {
            switch condition {
            case .win:
                playerWins += 1
                playerWinGame?(playerPoints, opponentPoints)
                prepareModelForNewDraft()
            case .lose:
                opponentWins += 1
                playerLoseGame?(playerPoints, opponentPoints)
                prepareModelForNewDraft()
            default: break
            }
        } else {
            switch condition {
            case .win:
                opponentWins += 1
                playerLoseGame?(playerPoints, opponentPoints)
                prepareModelForNewDraft()
            case .lose:
                playerWins += 1
                playerWinGame?(playerPoints, opponentPoints)
                prepareModelForNewDraft()
            default: break
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

