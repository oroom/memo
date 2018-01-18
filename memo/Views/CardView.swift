//
//  CardView.swift
//  memo
//
//  Created by Dzimtry Navak on 1/15/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation
import UIKit

protocol CardViewDelegate: class {
    func didFlipped(cardView: CardView)
}

class CardView: UIView {
    
    weak var delegate: CardViewDelegate?
    
    private var faceView: UIImageView
    private var backView: UIImageView
    
    init(faceName: String) {
        faceView = UIImageView(image: UIImage(named: faceName))
        backView = UIImageView(image: UIImage(named: "card_back")?.withRenderingMode(.alwaysTemplate))
        super.init(frame: CGRect.zero)
        
        backView.contentMode = .scaleAspectFit
        faceView.contentMode = .scaleAspectFit
        // face is hidden by default
        faceView.isHidden = true
        
        backView.backgroundColor = UIColor.white
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        add(subview: faceView, to: self)
        add(subview: backView, to: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTouch() {
        addTouchToVIew(view: backView)
    }
    
    private func add(subview: UIView, to cardView: UIView) {
        cardView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: cardView.rightAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: cardView.leftAnchor).isActive = true
    }
    
    func addTouchToVIew(view: UIView) {
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipView(sender:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(touchRecognizer)
    }
    
    func showFace() {
        if faceView.isHidden {
            flipView()
        }
    }
        
    func showBack() {
        if backView.isHidden {
            flipView()
        }
    }
    
    func flipView() {
        if faceView.isHidden {
            flip(from: backView, to: faceView, animated: true, isUserInitiated: false)
        }
        else {
            flip(from: faceView, to: backView, animated: true, isUserInitiated: false)
        }
    }
    
    private func flip(from: UIView, to: UIView, animated: Bool, isUserInitiated: Bool) {
        if animated {
            UIView.transition(from: from,
                              to: to,
                              duration: 0.3,
                              options: [.transitionFlipFromRight, .showHideTransitionViews]) { finished in
                                if finished {
                                    if isUserInitiated {
                                        self.delegate?.didFlipped(cardView: self)
                                    }
                                }
            }
        }
        else {
            from.isHidden = true
            to.isHidden = false
        }
    }
    
    @objc private func flipView(sender: UITapGestureRecognizer) {
        flip(from: backView, to: faceView, animated: true, isUserInitiated: true)
    }
}
