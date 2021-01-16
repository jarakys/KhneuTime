//
//  CollectionViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

protocol TableViewControllerDelegate: class {
    func didTap(indexPath: IndexPath)
}

protocol TableViewDataSourceConfigurable {
    associatedtype Item
    var items:[Item] { get set}
}

class TableViewController<T>: UIViewController, TableViewDataSourceConfigurable, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    
    var delegate: TableViewControllerDelegate?
    var configure:(() -> Void)? = {}
    
    var reusableCell: ReusableCell?
    
    typealias Item = T
    var items: [T] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        guard let cell = reusableCell else {
            fatalError("No register cell")
        }
//        tableView.register(cell.nib, forCellReuseIdentifier: cell.reusableIndentify)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func configureView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCell!.reusableIndentify, for: indexPath)
//        let item = items[indexPath.row]
//        if let configurableCell = cell as? ConfigurableViewCell<T> {
//            configurableCell.configure(item: item)
//        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTap(indexPath: indexPath)
    }
}
