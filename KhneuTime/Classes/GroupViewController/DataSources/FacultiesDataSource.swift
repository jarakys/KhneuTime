//
//  FacultiesDataSource.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit

protocol ConfigurableOnPushCellDelegate: class {
    func didTap(indexPath: IndexPath, cellType: CellType)
}

class FacultiesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var title: String
    private weak var delegate: ConfigurableOnPushCellDelegate?
    
    init(title: String, delegate: ConfigurableOnPushCellDelegate) {
        self.title = title
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reusableIndentify) as! HeaderView
        view.headerTitleLabel.text = "Faculty"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FacultyCell.reusableIndentify, for: indexPath) as! FacultyCell
        cell.top = true
        cell.bottom = true
        cell.configure(title: title, cellType: .specialty)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FacultyCell
        delegate?.didTap(indexPath: indexPath, cellType: cell.cellType)
    }
}