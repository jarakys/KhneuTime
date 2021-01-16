//
//  FacultyCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit

enum CellType {
    case faculty
    case specialty
    case course
    case group
}

class FacultyCell: RoundedGroupCell, ReusableCell {

    @IBOutlet private weak var titleLabel: UILabel!
    var cellType: CellType = .faculty
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(title: String, cellType: CellType) {
        titleLabel.text = title
        self.cellType = cellType
    }
}
