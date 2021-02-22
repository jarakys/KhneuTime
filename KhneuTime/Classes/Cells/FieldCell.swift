//
//  FieldCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.02.2021.
//

import UIKit

class FieldCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(value: String) {
        textField.text = value
    }
}
