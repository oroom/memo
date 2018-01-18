//
//  ViewController.swift
//  memo
//
//  Created by Artsiom Sadyryn on 12/27/17.
//  Copyright © 2017 Artsiom Sadyryn. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, CardViewDelegate {

    private var cardsContainer: CardsContainer!
    var cardViews = [CardView]()
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cardPairs = 8
        game = Game(cardPairs: cardPairs)
        createGame(cards: game.cards)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func createGame(cards: [Card]) {
        createContainer()
        
        for card in cards {
            let cardView = CardView(faceName: card.imageName)
            
            cardView.addTouch()
            cardViews.append(cardView)
            self.cardsContainer.addSubview(cardView)
            cardView.delegate = self
            cardView.translatesAutoresizingMaskIntoConstraints = false
            if card.isFlipped {
                cardView.flipView()
            }
        }
        
        cardsContainer.layout()
    }
    
    private func updateGame() {
        for (index, card) in game.cards.enumerated() {
            let cardView = cardViews[index]
            if card.isFlipped {
                cardView.showFace()
            }
            else {
                cardView.showBack()
            }
        }
    }
    
    private func createContainer() {
        cardsContainer = CardsContainer()
        cardsContainer.backgroundColor = UIColor.lightGray
        view.addSubview(cardsContainer)
        cardsContainer.translatesAutoresizingMaskIntoConstraints = false
        cardsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardsContainer.widthAnchor.constraint(equalTo: cardsContainer.heightAnchor).isActive = true
        cardsContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cardsContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    private func indexFor(card: CardView?) -> Int? {
        guard let card = card else {
            return nil
        }
        return cardViews.index(of: card)
    }
    
    func didFlipped(cardView: CardView) {
        if let tappedIndex = indexFor(card: cardView) {
            game.cardFlipped(at: tappedIndex)
        }
        updateGame()
    }
    
}
