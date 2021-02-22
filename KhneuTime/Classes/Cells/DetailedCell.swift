//
//  DetailedCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 21.02.2021.
//

import UIKit

class DetailedCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: DetailedModelProtocol) {
        titleLabel.text = data.nameDetailed
    }
}
