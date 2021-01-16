//
//  OptionCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 15.01.2021.
//

import UIKit

class OptionCell: RoundedGroupCell, ReusableCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: UIImage?, title: String) {
        iconImageView.image = image
        titleLabel.text = title
    }
}
