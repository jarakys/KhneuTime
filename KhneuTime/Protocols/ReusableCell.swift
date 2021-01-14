//
//  ReusableCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

protocol ReusableCell {
    var reusableIndentify: String { get }
    var nib: UINib { get }
}

extension ReusableCell {
    var reusableIndentify: String{
        return String(describing: self)
    }
    
    var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
