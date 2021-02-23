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
        selectionButton.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
    }
    
    @objc private func didTap(_ sender: UIButton) {
        guard let node = self.node else { return }
        if !node.state.values.contains(node.id) {
            node.state.values.append(node.id)
        } else {
            node.state.values.removeAll(where: { $0 == node.id})
        }
        checkmarkImageView.image = node.state.values.contains(node.id) ? UIImage(systemName: "checkmark.circle.fill") : nil
    }
    
    func config(node: SettingNode) {
        guard let groupNode = node as? ConfigureGroupViewModel.SelectableGroupNode else { return }
        self.node = groupNode
        selectionButton.setTitle(groupNode.title, for: .normal)
        checkmarkImageView.image = groupNode.state.values.contains(groupNode.id) ? UIImage(systemName: "checkmark.circle.fill") : nil
    }

}
