//
//  FacultyCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit

var nodeAssociationKey: UInt8 = 0

protocol NodeExtendable {
    associatedtype NodeType: SettingNode
    var node: NodeType? { get set }
}

extension NodeExtendable where Self: UITableViewCell {
    var node: NodeType? {
        get { objc_getAssociatedObject(self, &nodeAssociationKey) as? NodeType }
        set { objc_setAssociatedObject(self, &nodeAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
}

class SelectableCell: RoundedGroupCell, GroupConfigurableNode, NodeExtendable, ReusableCell {
    typealias NodeType = ConfigureGroupViewModel.SelectableDropdownNode
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var slectorButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView()
        view.backgroundColor = .clear
        self.selectedBackgroundView = view
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func config(node: SettingNode) {
        guard let dropdownNode = node as? ConfigureGroupViewModel.SelectableDropdownNode else { return }
        self.node = dropdownNode
        titleLabel.text = dropdownNode.title
        slectorButton.setTitle(dropdownNode.state.value.isEmpty ? dropdownNode.placeholder : dropdownNode.state.value, for: .normal)
        containerView.layer.cornerRadius = 8
    }
    
    func update(data: DetailedModelProtocol) {
        self.node?.state.id = data.idDetailed
        self.node?.state.value = data.nameDetailed
    }
    
    @IBAction func selectorDidTap(_ sender: Any) {
        guard let node = self.node else { return }
        node.didTapAction()
    }
}
