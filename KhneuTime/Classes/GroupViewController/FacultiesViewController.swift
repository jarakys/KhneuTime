//
//  FacultiesViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class FacultiesViewController: CoordinableViewController {
    
    @IBOutlet weak var groupsTableView: UITableView!
    
    private lazy var viewModel: ConfigureGroupViewModel = {
        let dataSource = ConfigureGroupDataSource()
        return ConfigureGroupViewModel(dataSource: dataSource, coordinator: coordinator!)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        groupsTableView.register(SelectableCell.nib, forCellReuseIdentifier: SelectableCell.reusableIndentify)
        groupsTableView.register(LabelCell.nib, forCellReuseIdentifier: LabelCell.reusableIndentify)
        groupsTableView.register(SelectableGroupCell.nib, forCellReuseIdentifier: SelectableGroupCell.reusableIndentify)
        groupsTableView.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.reusableIndentify)
        
        viewModel.setup()
        
        viewModel.$nodes.subscribe(self, callback: {[weak self] _ in
            self?.groupsTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension FacultiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.nodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let node = viewModel.nodes[indexPath.row]
        
        if node is ConfigureGroupViewModel.SelectableDropdownNode {
            cell = tableView.dequeueReusableCell(withIdentifier: SelectableCell.reusableIndentify, for: indexPath)
        } else if node is ConfigureGroupViewModel.LabelSeparator {
            cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.reusableIndentify, for: indexPath)
        } else if node is ConfigureGroupViewModel.SelectableGroupNode {
            cell = tableView.dequeueReusableCell(withIdentifier: SelectableGroupCell.reusableIndentify, for: indexPath)
        }
        if viewModel.nodes.firstIndex(where: {$0 is ConfigureGroupViewModel.LabelSeparator}) == indexPath.row - 1 {
            (cell as? RoundedGroupCell)?.top = true
        }
        if viewModel.nodes.count - 1 == indexPath.row {
            (cell as? RoundedGroupCell)?.bottom = true
        }
        (cell as? GroupConfigurableNode)?.config(node: node)
        return cell
    }
}

////MARK: UIPickerViewDelegate, UIPickerViewDataSource
//extension FacultiesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        4
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        (row + 1).description
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        guard let courseIndexPath = groupsTableView.indexPathForSelectedRow else { return }
//        coursesDataSource.updateTitle(title: (row + 1).description)
//        groupsTableView.reloadRows(at: [courseIndexPath], with: .none)
//        selectedCourse = row + 1
//        backgroundPickerView.isHidden = true
//    }
//}
//
////MARK: CoursesDataSourceDelegate
//extension FacultiesViewController: CoursesDataSourceDelegate {
//    func courseDidTap(indexPath: IndexPath) {
//        backgroundPickerView.isHidden = false
//    }
//}
//

