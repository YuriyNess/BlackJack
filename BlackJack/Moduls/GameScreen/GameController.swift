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
        initViewController()
        setupActions()
    }
    
    private func initViewController() {
        mainView.opponentCardsCollection.dataSource = self
        mainView.opponentCardsCollection.delegate = self
        mainView.opponentCardsCollection.registerReusableCell(CardCell.self)
        mainView.playerCardsCollection.dataSource = self
        mainView.playerCardsCollection.delegate = self
        mainView.playerCardsCollection.registerReusableCell(CardCell.self)
    }
    
    private func setupActions() {
        mainView.oneMoreCard.addTarget(self, action: #selector(addOneMoreCard), for: .touchUpInside)
    }
}

//MARK: - Actions
extension GameController {
    @objc private func addOneMoreCard() {
        viewModel.playerCards.append("+1")
        mainView.playerCardsCollection.reloadData()
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
            cell.backgroundColor = .white
            cell.text.text = viewModel.opponentCards[indexPath.row]
            return cell
        } else {
            let cell: CardCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.backgroundColor = .orange
            cell.text.text = viewModel.playerCards[indexPath.row]
            return cell
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
