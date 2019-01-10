//
//  CellLabel.swift
//  SchotersTest
//
//  Created by nurpariz on 10/01/19.
//  Copyright © 2019 nurpariz. All rights reserved.
//

import UIKit

class CellLabel: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            let color = UIColor(red: 27.0/255.0, green: 202.0/255.0, blue: 204.0/255.0, alpha: 1)
            self.contentView.backgroundColor = isSelected ? color : UIColor.white
            self.cellLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
}


