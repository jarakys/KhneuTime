//
//  OptionDataSource.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 15.01.2021.
//

import UIKit

class OptionDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let options: [OptionsEnum]
    
    init(options: [OptionsEnum]) {
        self.options = options
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reusableIndentify) as! HeaderView
        view.headerTitleLabel.text = "Options"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reusableIndentify, for: indexPath) as! OptionCell
        if indexPath.row == 0 {
            cell.top = true
        }
        if indexPath.row == options.count - 1 {
            cell.bottom = true
        }
        let model = options[indexPath.row]
        cell.configure(image: UIImage(named: model.iconName), title: model.description)
        return cell
    }
}
