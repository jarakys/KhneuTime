//
//  ScheduleViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 25.02.2021.
//

import UIKit
import CoreData

class ScheduleViewController: CoordinableViewController {

    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var group: GroupDB!
    
    private var selectedDate: Date = Date()
    
    private var fetchController: NSFetchedResultsController<ScheduleDb>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        scheduleTableView.contentInsetAdjustmentBehavior = .never
        title = group.name ?? ""
        fetchController = DatabaseManager.shared.getSchedule(groupId: Int(group.id), unixDate: Int64(selectedDate.startOfDay.timeIntervalSince1970))
        try? fetchController.performFetch()
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.register(ScheduleCell.nib, forCellReuseIdentifier: ScheduleCell.reusableIndentify)
        scheduleTableView.register(NoDataCell.nib, forCellReuseIdentifier: NoDataCell.reusableIndentify)
        dateLabel.text = selectedDate.getDescription(by: "E, dd MMM")
        
        let updateItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(updateSchedule(_:)))
        navigationItem.rightBarButtonItems = [updateItem]
    }
    
    private func getSchedule() {
        fetchController = DatabaseManager.shared.getSchedule(groupId: Int(group.id), unixDate: Int64(selectedDate.startOfDay.timeIntervalSince1970))
        try? fetchController.performFetch()
        scheduleTableView.reloadData()
    }
    
    @objc
    private func updateSchedule(_ sender: Any) {
        coordinator?.presentAlert(title: "Waiting", message: "Update schedule", actiions: [], callback: { _ in })
        SyncManager.shared.setSchedule(for: Int(group.id), completion: {[weak self]_ in
            self?.coordinator?.hideAlert()
        })
    }
    
    @IBAction func nextButtonDidTap(_ sender: Any) {
        // Add Date + 1
        getSchedule()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        // Add Date + 1
        getSchedule()
    }
    
    @IBAction func calendarDidTap(_ sender: Any) {
        coordinator?.openCalendar(selectedDate: selectedDate, doneAction: {[weak self] selectedDate in
            self?.selectedDate = selectedDate
            self?.getSchedule()
        })
        getSchedule()
    }
    
}

extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        max(1, (fetchController.fetchedObjects?.count ?? 0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fetchController.fetchedObjects?.count == nil || fetchController.fetchedObjects?.count == 0  {
            return tableView.dequeueReusableCell(withIdentifier: NoDataCell.reusableIndentify, for: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reusableIndentify, for: indexPath) as! ScheduleCell
        let model = fetchController.object(at: indexPath)
        cell.configure(name: model.subjectFullName ?? "", type: model.type ?? "", location: model.location ?? "", teacher: model.teacherShortName ?? "", time: Date(timeIntervalSince1970: TimeInterval(Int(model.startUnix!)!)).getDescription(by: "HH:mm"))
        return cell
    }
}
