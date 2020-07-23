//
//  GameView.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit
import SnapKit

final class GameView: UIView {
    
    static let labelTextHeigh: CGFloat = SizeHelper.sizeW(18)
    static let buttonTextHeigh: CGFloat = SizeHelper.sizeW(28)
    static let deskHeigh: CGFloat = SizeHelper.sizeH(121)
    
    let opponentAvatar: UIImageView = {
        let obj = UIImageView(image: UIImage(named: "")) // TODO image
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.backgroundColor = .white
        return obj
    }()
    
    let opponentName: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: labelTextHeigh, weight: .regular)
        obj.textColor = .black
        obj.text = "Bill Gates"
        obj.textAlignment = .left
        obj.textColor = .white
        return obj
    }()
    
    let randNewOpponent: UIButton = {
        let obj = UIButton(type: .system)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .clear
        obj.tintColor = .white
        obj.setImage(UIImage(named: "random")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return obj
    }()
    
    let opponentDesk: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.layer.borderWidth = 3
        obj.layer.borderColor = UIColor.Game.gray.cgColor
        obj.cornerRadius = 5
        return obj
    }()
    
    let opponentCardsCollection: OpponentCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let obj = OpponentCollectionView(frame: .zero, collectionViewLayout: layout)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.registerReusableCell(UICollectionViewCell.self)
        obj.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return obj
    }()
    
    let opponentPoints: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: labelTextHeigh, weight: .regular)
        obj.textColor = .black
        obj.text = "Points: 5"
        obj.textAlignment = .center
        obj.textColor = .white
        return obj
    }()
    
    let opponentWins: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: labelTextHeigh, weight: .regular)
        obj.textColor = .black
        obj.text = "Wins: 3"
        obj.textAlignment = .center
        obj.textColor = .white
        return obj
    }()
    
    let endTurn: UIButton = {
        let obj = UIButton(type: .system)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .clear
        obj.layer.borderWidth = 2
        obj.layer.borderColor = UIColor.white.cgColor
        obj.tintColor = .white
        obj.setImage(UIImage(named: "tick")?.withRenderingMode(.alwaysTemplate), for: .normal)
        obj.cornerRadius = 8
        return obj
    }()
    
    let cardsDeck: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .purple//.white
        obj.cornerRadius = 10
        return obj
    }()
    
    let oneMoreCard: UIButton = {
        let obj = UIButton(type: .system)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .clear
        obj.layer.borderWidth = 2
        obj.layer.borderColor = UIColor.white.cgColor
        let attrString = NSAttributedString(string: "+1", attributes: [
            .font: UIFont.systemFont(ofSize: buttonTextHeigh, weight: .medium),
            .foregroundColor: UIColor.white])
        obj.setAttributedTitle(attrString, for: .normal)
        obj.cornerRadius = 8
        return obj
    }()
    
    let playerDesk: UIView = {
       let obj = UIView()
       obj.translatesAutoresizingMaskIntoConstraints = false
       obj.layer.borderWidth = 3
       obj.layer.borderColor = UIColor.Game.gray.cgColor
       obj.cornerRadius = 5
        return obj
    }()
    
    let playerCardsCollection: PlayerCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let obj = PlayerCollectionView(frame: .zero, collectionViewLayout: layout)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.registerReusableCell(UICollectionViewCell.self)
        obj.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return obj
    }()
    
    let playerPoints: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: labelTextHeigh, weight: .regular)
        obj.textColor = .black
        obj.text = "Points: 5"
        obj.textAlignment = .center
        obj.textColor = .white
        return obj
    }()
    
    let playerWins: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: labelTextHeigh, weight: .regular)
        obj.textColor = .black
        obj.text = "Wins: 3"
        obj.textAlignment = .center
        obj.textColor = .white
        return obj
    }()
    
    let refreshScore: UIButton = {
        let obj = UIButton(type: .system)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .clear
        obj.tintColor = .white
        obj.setImage(UIImage(named: "refresh")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return obj
    }()
    
    let playerName: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: labelTextHeigh, weight: .regular)
        obj.textColor = .black
        obj.text = "You"
        obj.textAlignment = .right
        obj.textColor = .white
        return obj
    }()
    
    let playerAvatar: UIImageView = {
        let obj = UIImageView(image: UIImage(named: "")) // TODO image
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.backgroundColor = .white
        return obj
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .black
        
        addSubview(opponentAvatar)
        addSubview(opponentName)
        addSubview(randNewOpponent)
        addSubview(opponentDesk)
        opponentDesk.addSubview(opponentCardsCollection)
        addSubview(opponentPoints)
        addSubview(opponentWins)
        addSubview(endTurn)
        addSubview(cardsDeck)
        addSubview(oneMoreCard)
        addSubview(playerPoints)
        addSubview(playerWins)
        addSubview(playerDesk)
        playerDesk.addSubview(playerCardsCollection)
        addSubview(refreshScore)
        addSubview(playerName)
        addSubview(playerAvatar)
        
        opponentAvatar.snp.makeConstraints { (make) in
            //make.top.equalToSuperview().offset(SizeHelper.sizeH(77))
            make.leading.equalToSuperview().offset(SizeHelper.sizeW(27))
            make.width.height.equalTo(SizeHelper.sizeW(54))
        }
        
        opponentName.snp.makeConstraints { (make) in
            make.leading.equalTo(opponentAvatar.snp.trailing).offset(SizeHelper.sizeW(17))
            make.centerY.equalTo(opponentAvatar)
        }
        
        randNewOpponent.snp.makeConstraints { (make) in
            make.leading.equalTo(opponentName.snp.trailing).offset(SizeHelper.sizeW(30))
            make.trailing.equalToSuperview().offset(SizeHelper.sizeW(-27))
            make.centerY.equalTo(opponentAvatar)
        }
        
        opponentDesk.snp.makeConstraints { (make) in
            make.top.equalTo(opponentAvatar.snp.bottom).offset(SizeHelper.sizeH(8))
            make.leading.equalTo(opponentAvatar)
            make.trailing.equalTo(randNewOpponent)
            make.height.equalTo(GameView.deskHeigh)
            make.bottom.equalTo(cardsDeck.snp.top).offset(SizeHelper.sizeH(-80))
        }
        
        opponentCardsCollection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        opponentPoints.snp.makeConstraints { (make) in
            make.top.equalTo(opponentDesk.snp.bottom).offset(SizeHelper.sizeH(14))
            make.leading.equalTo(opponentAvatar)
        }
        
        opponentWins.snp.makeConstraints { (make) in
            make.top.equalTo(opponentPoints)
            make.trailing.equalTo(randNewOpponent)
        }
        
        cardsDeck.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(SizeHelper.sizeW(168))
            make.height.equalTo(SizeHelper.sizeH(252))
        }
        
        endTurn.snp.makeConstraints { (make) in
            make.centerY.equalTo(cardsDeck)
            make.trailing.equalTo(cardsDeck.snp.leading).offset(SizeHelper.sizeW(-22))
            make.width.equalTo(SizeHelper.sizeW(76))
            make.height.equalTo(SizeHelper.sizeW(51))
        }
        
        oneMoreCard.snp.makeConstraints { (make) in
            make.centerY.equalTo(cardsDeck)
            make.leading.equalTo(cardsDeck.snp.trailing).offset(SizeHelper.sizeW(22))
            make.width.equalTo(SizeHelper.sizeW(76))
            make.height.equalTo(SizeHelper.sizeW(51))
        }
        
        playerPoints.snp.makeConstraints { (make) in
            make.leading.equalTo(opponentAvatar)
            make.bottom.equalTo(playerDesk.snp.top).offset(SizeHelper.sizeH(-14))
        }

        playerWins.snp.makeConstraints { (make) in
            make.top.equalTo(playerPoints)
            make.trailing.equalTo(randNewOpponent)
        }
        
        playerDesk.snp.makeConstraints { (make) in
            make.top.equalTo(cardsDeck.snp.bottom).offset(SizeHelper.sizeH(80))
            make.leading.equalTo(opponentAvatar)
            make.trailing.equalTo(randNewOpponent)
            make.height.equalTo(GameView.deskHeigh)
        }
        
        playerCardsCollection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        refreshScore.snp.makeConstraints { (make) in
            make.leading.equalTo(opponentAvatar)
            make.top.equalTo(playerDesk.snp.bottom).offset(SizeHelper.sizeH(14))
            make.width.height.equalTo(SizeHelper.sizeW(54))
        }
        
        playerName.snp.makeConstraints { (make) in
            make.leading.equalTo(refreshScore.snp.trailing).offset(SizeHelper.sizeW(17))
            make.centerY.equalTo(refreshScore)
        }
        
        playerAvatar.snp.makeConstraints { (make) in
            make.top.equalTo(refreshScore)
            make.leading.equalTo(playerName.snp.trailing).offset(SizeHelper.sizeW(17))
            make.trailing.equalTo(randNewOpponent)
            make.width.height.equalTo(SizeHelper.sizeW(54))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        opponentAvatar.roundShape()
        playerAvatar.roundShape()
    }
}
