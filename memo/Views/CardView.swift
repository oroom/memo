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
    
    
    @objc func flipView(sender: UITapGestureRecognizer) {
        
        if let imageView = sender.view as? UIImageView {
            let faceView = imageView.superview?.subviews.filter { $0 != imageView }.first
            if let face = faceView {
                UIView.transition(from: imageView,
                                  to: face,
                                  duration: 0.3,
                                  options: [.transitionFlipFromRight, .showHideTransitionViews]) { finished in
                                    if finished {
                                        self.delegate?.didFlipped(cardView: self)
                                    }
                }
            }
        }
        
    }
}
