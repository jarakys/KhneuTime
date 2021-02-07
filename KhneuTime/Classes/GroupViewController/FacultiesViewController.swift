//
//  FacultiesViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class FacultiesViewController: CoordinableViewController {
    
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var groupsTableView: UITableView!
    
    private var dataSources = [UITableViewDataSource & UITableViewDelegate]()
    private var coursesDataSource: CoursesDataSource!
    private var selectableGroupsDataSource: SelectableGroupsDataSource!
    private var facultiesDataSource: FacultiesDataSource!
    private var specialtiesDataSource: SpecialtiesDataSource!
    
    private var selectetCourse: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        coursePicker.delegate = self
        coursePicker.dataSource = self
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        groupsTableView.register(FacultyCell.nib, forCellReuseIdentifier: FacultyCell.reusableIndentify)
        groupsTableView.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.reusableIndentify)
        
        coursesDataSource = CoursesDataSource(title: "1", delegate: self)
        selectableGroupsDataSource = SelectableGroupsDataSource()
        facultiesDataSource = FacultiesDataSource(title: "IT", delegate: self)
        specialtiesDataSource = SpecialtiesDataSource(title: "CS", delegate: self)
        
        dataSources = [facultiesDataSource, specialtiesDataSource, coursesDataSource, selectableGroupsDataSource,]
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension FacultiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSources.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dataSources[section].tableView?(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        dataSources[section].tableView?(tableView, heightForHeaderInSection: section) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSources[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataSources[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSources[indexPath.section].tableView?(tableView, didSelectRowAt: indexPath)
    }
}

//MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension FacultiesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        (row + 1).description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let courseIndexPath = groupsTableView.indexPathForSelectedRow else { return }
        coursesDataSource.updateTitle(title: (row + 1).description)
        groupsTableView.reloadRows(at: [courseIndexPath], with: .none)
        selectetCourse = row + 1
        pickerView.isHidden = true
    }
}

//MARK: CoursesDataSourceDelegate
extension FacultiesViewController: CoursesDataSourceDelegate {
    func courseDidTap(indexPath: IndexPath) {
        coursePicker.isHidden = false
    }
}

//MARK: SelectableGroupsDataSourceDelegate
extension FacultiesViewController: SelectableGroupsDataSourceDelegate {
    func groupDidTap(indexPath: IndexPath) {
        
    }
}

//MARK: ConfigurableOnPushCellDelegate
extension FacultiesViewController: ConfigurableOnPushCellDelegate {
    func didTap(indexPath: IndexPath, cellType: CellType, data: [DetailedModelProtocol]) {
        coordinator?.startSelectableDetail(data: data, completion: {[weak self] selectedItem in
            guard let self = self else { return }
            self.dataSources[indexPath.section].updateDataTitle(title: selectedItem)
            self.groupsTableView.reloadSections(IndexSet(indexPath.section...self.dataSources.count-1), with: .none)
            self.groupsTableView.reloadRows(at: [indexPath], with: .automatic)
        })
    }
}
