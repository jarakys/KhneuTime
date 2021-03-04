//
//  GroupsDataSource.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 15.01.2021.
//

import UIKit
import CoreData

class GroupsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var fetchController: NSFetchedResultsController<GroupDB> {
        let fetchController = DatabaseManager.shared.getGroups(by: PrefsManager.shared.get(pref: .selectedGroups) ?? [])
        try? fetchController.performFetch()
        return fetchController
    }
    weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator) {
        super.init()
        self.coordinator = coordinator
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let model = fetchController.fetchedObjects![indexPath.row]
        var groups: [Int] = PrefsManager.shared.get(pref: .selectedGroups) ?? []
        groups.removeAll(where: { $0 == model.id })
        DatabaseManager.shared.deleteSchedule(for: Int(model.id))
        PrefsManager.shared.set(pref: .selectedGroups, value: groups)
        try? fetchController.performFetch()
        tableView.reloadData()
    }
}

