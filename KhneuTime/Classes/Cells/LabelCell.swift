//
//  LabelCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 21.02.2021.
//

import UIKit

class LabelCell: UITableViewCell, ReusableCell, GroupConfigurableNode {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(node: SettingNode) {
        guard let separatorNode = node as? ConfigureGroupViewModel.LabelSeparator else { return }
        titleLabel.text = separatorNode.title
    }
}
