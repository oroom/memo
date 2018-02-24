//
//  BestResultTableViewCell.swift
//  memo
//
//  Created by Dzimtry Navak on 1/29/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation
import UIKit

class BestResultTableViewCell: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
    }
    
    private func layout() {
        contentView.backgroundColor = UIColor.lightGray
        contentView.addSubViews(label, margins: UIEdgeInsets.zero)
    }
}
