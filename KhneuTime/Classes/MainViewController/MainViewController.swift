//
//  MainViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 15.01.2021.
//

import UIKit

class MainViewController: CoordinableViewController {

    @IBOutlet weak var infoTableView: UITableView!
    
    var dataSources = [UITableViewDelegate & UITableViewDataSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(OptionCell.nib, forCellReuseIdentifier: OptionCell.reusableIndentify)
        infoTableView.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.reusableIndentify)
        dataSources.append(OptionDataSource(options: OptionsEnum.allCases, delegate: self))
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dataSource = dataSources[section]
        let view = dataSource.tableView?(tableView, viewForHeaderInSection: section)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        dataSources[section].tableView?(tableView, heightForHeaderInSection: section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSources.count
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

//MARK: ConfigurableOptionOnPushCellDelegate
extension MainViewController: ConfigurableOptionOnPushCellDelegate {
    func didTap(indexPath: IndexPath, option: OptionsEnum) {
        switch option {
        case .groups:
            coordinator?.startConfigureGroupVC()
        case .teachers:
            coordinator?.startConfigureTeacherVC()
        }
    }
}
