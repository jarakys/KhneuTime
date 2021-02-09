//
//  SpecialtiesDataSource.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit
import CoreData

class SpecialtiesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, Updatable {

    private var title: String
    private weak var delegate: ConfigurableOnPushCellDelegate?
    private var specialtiesFetchController = DatabaseManager.shared.getSpecialties(facultyId: -1)
    
    init(title: String, delegate: ConfigurableOnPushCellDelegate) {
        self.title = title
        self.delegate = delegate
        
    }
    
    func updateTitle(title: String) {
        self.title = title
    }
    
    func updateData(subsectionId: Int) {
        specialtiesFetchController = DatabaseManager.shared.getSpecialties(facultyId: subsectionId)
        try? specialtiesFetchController.performFetch()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reusableIndentify) as! HeaderView
        view.headerTitleLabel.text = "Specialty"
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
        let data = specialtiesFetchController.fetchedObjects ?? []
        delegate?.didTap(indexPath: indexPath, cellType: cell.cellType, data: data)
    }
}
