//
//  SelectableGroupCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 21.02.2021.
//

import UIKit

protocol SelectableGroupDelegate: class {
    func didTap()
}

class SelectableGroupCell: RoundedGroupCell, ReusableCell, GroupConfigurableNode, NodeExtendable {
    
    typealias NodeType = ConfigureGroupViewModel.SelectableGroupNode
    
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    private var wasSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard let node = self.node else { return }
        if selected {
            node.state.values.append(node.id)
        }
    }
    
    func config(node: SettingNode) {
        guard let groupNode = node as? ConfigureGroupViewModel.SelectableGroupNode else { return }
        self.node = groupNode
        selectionButton.setTitle(groupNode.title, for: .normal)
        checkmarkImageView.image = groupNode.state.values.contains(groupNode.id) ? UIImage(systemName: "checkmark.circle.fill") : nil
    }

}
