//
//  GameController.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

final class GameController: UIViewController {
    
    let mainView = GameView()
    private let viewModel = GameViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupActions()
        setupViewModelCallBacks()
        viewModel.refreshGameScore()
    }
    
    private func setupViewController() {
        mainView.opponentCardsCollection.dataSource = self
        mainView.opponentCardsCollection.delegate = self
        mainView.opponentCardsCollection.registerReusableCell(CardCell.self)
        mainView.playerCardsCollection.dataSource = self
        mainView.playerCardsCollection.delegate = self
        mainView.playerCardsCollection.registerReusableCell(CardCell.self)
    }
    
    private func setupActions() {
        mainView.oneMoreCard.addTarget(self, action: #selector(addOneMoreCard), for: .touchUpInside)
        mainView.endTurn.addTarget(self, action: #selector(endPlayerTurn), for: .touchUpInside)
        mainView.refreshScore.addTarget(self, action: #selector(handleRefreshScore), for: .touchUpInside)
    }
    
    private func setupViewModelCallBacks() {
        viewModel.scoreWasRefreshed = { [weak self] opponentName, imageString in
            self?.mainView.opponentName.text = opponentName //TODO remove on adding rx
            self?.mainView.opponentAvatar.image = UIImage(named: opponentName)
        }
        
        viewModel.endTurnButtonStateChanged = { [weak self] isEnabled in
            self?.mainView.endTurn.isEnabled = isEnabled
        }
        
        viewModel.playerGetNewCardToHisHand = { [weak self] in
            self?.mainView.playerCardsCollection.reloadData()
            guard let lastIndexPath = self?.mainView.playerCardsCollection.lastIndexPath() else { return }
            self?.mainView.playerCardsCollection.scrollToItem(at: lastIndexPath, at: .right, animated: true)
        }
        viewModel.opponentGetNewCardToHisHand = { [weak self] in
            self?.mainView.opponentCardsCollection.reloadData()
            guard let lastIndexPath = self?.mainView.opponentCardsCollection.lastIndexPath() else { return }
            self?.mainView.opponentCardsCollection.scrollToItem(at: lastIndexPath, at: .right, animated: true)
        }
        
        viewModel.playerWinGame = { [weak self] playerPoints, opponentPoints in
            self?.showAlertWith(title: "Win", message: "Your points = \(playerPoints)\nOpponent points = \(opponentPoints)", compltetion: { [weak self] in
                self?.viewModel.makeNewDraft()
            })
        }
        viewModel.playerLoseGame = { [weak self] playerPoints, opponentPoints in
            self?.showAlertWith(title: "Lose", message: "Your points = \(playerPoints)\nOpponent points = \(opponentPoints)", compltetion: { [weak self] in
                self?.viewModel.makeNewDraft()
            })
        }
        viewModel.playerDrawGame = { [weak self] pointsBoth in
            self?.showAlertWith(title: "Draw", message: "Both points = \(pointsBoth)", compltetion: { [weak self] in
                self?.viewModel.makeNewDraft()
            })
        }
        
        viewModel.playerPointsChanged = { [weak self] points in
            self?.mainView.playerPoints.text = "Points: \(points)"
        }
        viewModel.opponentPointsChanged = { [weak self] points in
            self?.mainView.opponentPoints.text = "Points: \(points)"
        }
        viewModel.playerWinsChanged = { [weak self] wins in
            self?.mainView.playerWins.text = "Wins: \(wins)"
        }
        viewModel.opponentWinsChanged = { [weak self] wins in
            self?.mainView.opponentWins.text = "Wins: \(wins)"
        }
        viewModel.removeAllCardsFromPlayersHand = { [weak self] in
            self?.mainView.playerCardsCollection.reloadData()
        }
        viewModel.removeAllCardsFromOpponentsHand = { [weak self] in
            self?.mainView.opponentCardsCollection.reloadData()
        }
        
        //Opponent sending events
        viewModel.opponentDecideToTakeOneMoreCard = { [weak self] in
            self?.addOneMoreCard()
        }
        
        viewModel.opponentDecideToFinishTurn = { [weak self] in
            self?.viewModel.opponentFinishTurn()
        }
    }
}

//MARK: - Actions
extension GameController {
    @objc private func endPlayerTurn() {
        debugPrint("SDFF1234-1213-*****")
        viewModel.endTurn()
    }
    
    @objc private func addOneMoreCard() {
        viewModel.giveCardToActivePlayer()
    }
    
    @objc private func handleRefreshScore() {
        viewModel.refreshGameScore()
    }
}

extension GameController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView is OpponentCollectionView {
            return viewModel.opponentCards.count
        } else {
            return viewModel.playerCards.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView is OpponentCollectionView {
            let cell: CardCell = collectionView.dequeueReusableCell(for: indexPath)
            let card = viewModel.opponentCards[indexPath.row]
            setup(cell: cell, card: card)
            return cell
        } else {
            let cell: CardCell = collectionView.dequeueReusableCell(for: indexPath)
            let card = viewModel.playerCards[indexPath.row]
            setup(cell: cell, card: card)
            return cell
        }
    }
    
    private func setup(cell: CardCell, card: Card) {
        cell.topValue.text = card.value.rawValue
        cell.suitImage.image = UIImage(named: card.suit.getImageName())?.withRenderingMode(.alwaysTemplate)
        cell.suitImage.tintColor = getColor(suit: card.suit)
        cell.backgroundColor = .white
    }
    
    private func getColor(suit: Suits) -> UIColor {
        switch suit {
        case .clubs:
            return .black
        case .diamonds:
            return .red
        case .hearts:
            return .red
        case .spades:
            return .black
        }
    }
}

extension GameController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = GameView.deskHeigh - 18
        let width = height * 0.68
        return CGSize(width: width, height: height)
    }
}
