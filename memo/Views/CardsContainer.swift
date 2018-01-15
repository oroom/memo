//
//  CardsContainer.swift
//  memo
//
//  Created by Artsiom Sadyryn on 1/12/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//


import Foundation
import UIKit

class CardsContainer: UIView {
    func layout() {
        let views = self.subviews
        
        var inRow = 6
        let count = views.count
        if count <= 4 {
            inRow = 2
        }
        else if count <= 6 {
            inRow = 3
        }
        else if count <= 20 {
            inRow = 4
        }
        
        let margin: CGFloat = 16
        let size = (UIScreen.main.bounds.size.width - margin * CGFloat((inRow+1)))  / CGFloat(inRow)
        
        for (index, view) in views.enumerated() {
            
            view.heightAnchor.constraint(equalToConstant: size).isActive = true
            view.widthAnchor.constraint(equalToConstant: size).isActive = true
            
            if index == 0 {
                view.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
                view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
            }
            else {
                if (index - inRow) < 0 {
                    view.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
                }
                else {
                    view.topAnchor.constraint(equalTo: views[index - inRow].bottomAnchor, constant: margin).isActive = true
                }
                if index % inRow == 0 {
                    //newline
                    view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
                }
                else {
                    view.leftAnchor.constraint(equalTo: views[index-1].rightAnchor, constant: margin).isActive = true
                }
            }
            
        }
    }
}

