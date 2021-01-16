//
//  CourcesDataSource.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit

protocol CoursesDataSourceDelegate: class {
    func courseDidTap(indexPath: IndexPath)
}

class CoursesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var title: String
    weak var delegate: CoursesDataSourceDelegate?
    
    init(title: String, delegate: CoursesDataSourceDelegate) {
        self.title = title
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    public func updateTitle(title: String) {
        self.title = title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reusableIndentify) as! HeaderView
        view.headerTitleLabel.text = "Cource"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FacultyCell.reusableIndentify, for: indexPath) as! FacultyCell
        cell.top = true
        cell.bottom = true
        cell.configure(title: title, cellType: .course)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.courseDidTap(indexPath: indexPath)
    }
}
