//
//  TableCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class TableCell: ConfigurableViewCell<String>, ReusableCell {
    typealias DataType = String
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var titleCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        // Initialization code
    }
    
    var reusableIndentify: String{
        "TableCell"
    }
    
    var nib: UINib {
        UINib(nibName: "TableCell", bundle: nil)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configure(item: String) {
        accessoryType = .disclosureIndicator
        titleCell.text = item
    }
}
