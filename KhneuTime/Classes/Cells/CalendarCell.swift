//
//  CalendarCell.swift
//  MacronCRM
//
//  Created by Kyrylo Chernov on 05.10.2020.
//  Copyright © 2020 Macron. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell, ReusableCell {
    
    @IBOutlet weak var numberTitle: UILabel!

    func configure(number: String) {
        numberTitle.text = number
    }
}
