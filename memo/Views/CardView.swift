//
//  CardView.swift
//  memo
//
//  Created by Artsiom Sadyryn on 1/15/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation
import UIKit

protocol CardViewDelegate: class {
    func didFlipped(cardView: CardView)
}

class CardView: UIView {
    
    weak var delegate: CardViewDelegate?
    
    var isOpened: Bool {
        return backView.isHidden
    }
    
    private var faceView: UIImageView
    private var backView: UIImageView
    
    init(faceName: String, isOpened: Bool) {
        faceView = UIImageView(image: UIImage(named: faceName))
        faceView.isHidden = !isOpened
        backView = UIImageView(image: UIImage(named: "card_back")?.withRenderingMode(.alwaysTemplate))
        backView.isHidden = isOpened
        super.init(frame: CGRect.zero)
        
        backView.contentMode = .scaleAspectFit
        faceView.contentMode = .scaleAspectFit
        
        backView.backgroundColor = UIColor.white
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        add(subview: faceView, to: self)
        add(subview: backView, to: self)
        
        addTouch()
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
    
    func flipView() {
        let fromView = backView.isHidden ? faceView : backView
        let toView = backView.isHidden ? backView : faceView
        flipView(from: fromView, to: toView, userInitiated: false)
    }
    
    @objc func flipView(sender: UITapGestureRecognizer) {
        flipView(from: backView, to: faceView, userInitiated: true)
    }
    
    private func flipView(from: UIImageView, to: UIImageView, userInitiated: Bool) {
                UIView.transition(from: from,
                                  to: to,
                                  duration: 0.3,
                                  options: [.transitionFlipFromRight, .showHideTransitionViews]) { finished in
                                    if finished && userInitiated {
                                        self.delegate?.didFlipped(cardView: self)
                                    }
                                }
    }
}


