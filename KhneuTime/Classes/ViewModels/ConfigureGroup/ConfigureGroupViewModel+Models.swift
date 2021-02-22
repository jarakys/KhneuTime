//
//  ConfigureGroupViewModel+Models.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 21.02.2021.
//

import Foundation

protocol SettingNode { }


protocol GroupConfigurableNode {
    func config(node: SettingNode)
}

extension ConfigureGroupViewModel {
    
    class SelectableDropdownNodeState {
        @Binding var value = ""
        @Binding var id = -1
    }
    
    struct SelectableDropdownNode: SettingNode {
        let title: String
        let placeholder: String
        let options: [DetailedModelProtocol]
        let state: SelectableDropdownNodeState
        let didTapAction: () -> Void
    }
    
    class SelectableNodeState {
        @Binding var value = ""
        @Binding var id = -1
    }
    
    struct SelectableNode: SettingNode {
        let title: String
        let state: SelectableNodeState
    }
    
    class SelectableGroupNodeState {
        @Binding var values = [Int]()
    }
    
    struct SelectableGroupNode: SettingNode {
        let title: String
        let id: Int
        let state: SelectableGroupNodeState
    }
    
    struct LabelSeparator: SettingNode {
        let title: String
    }
    
}

extension ConfigureGroupViewModel {
    
    class State {
        
        let facultyState = SelectableDropdownNodeState()
        let specialtyState = SelectableDropdownNodeState()
        let courseState = SelectableDropdownNodeState()
        let groupsState = SelectableGroupNodeState()
        
        init(dataSource: ConfigureGroupDataSource) {
        }
    }
}
