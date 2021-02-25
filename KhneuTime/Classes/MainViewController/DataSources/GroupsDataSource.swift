//
//  GroupsDataSource.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 15.01.2021.
//

import UIKit

class GroupsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let fetchController = DatabaseManager.shared.getGroups(by: PrefsManager.shared.get(pref: .selectedGroups) ?? [])
    weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        try? fetchController.performFetch()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reusableIndentify) as! HeaderView
        view.headerTitleLabel.text = "Selected groups"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reusableIndentify, for: indexPath) as! OptionCell
        let model = fetchController.fetchedObjects![indexPath.row]
        cell.configure(image: UIImage(named: "calendar"), title: model.name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = fetchController.fetchedObjects![indexPath.row]
        coordinator?.openSchedule(for: model)
    }
}

