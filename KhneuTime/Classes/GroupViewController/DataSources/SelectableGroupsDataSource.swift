//
//  GroupsDataSource.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit

protocol SelectableGroupsDataSourceDelegate: class {
    func groupDidTap(indexPath: IndexPath)
}

class SelectableGroupsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private weak var delegate: SelectableGroupsDataSourceDelegate?
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reusableIndentify) as! HeaderView
        view.headerTitleLabel.text = "Groups"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FacultyCell.reusableIndentify, for: indexPath) as! FacultyCell
        cell.configure(title: "title", cellType: .group)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.groupDidTap(indexPath: indexPath)
    }
}
