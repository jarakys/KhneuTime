//
//  DetailViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 22.01.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailsViewController: UITableView!
    
    var didClose: ((String) -> Void)?
    
    var data = ["Data","Here","Must","Be","Real","Data"]
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.searchController = searchController
        detailsViewController.delegate = self
        detailsViewController.dataSource = self
        detailsViewController.register(FacultyCell.nib, forCellReuseIdentifier: FacultyCell.reusableIndentify)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        didClose?("hi")
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FacultyCell.reusableIndentify, for: indexPath) as! FacultyCell
        let model = data[indexPath.row]
        cell.configure(title: model, cellType: .faculty)
        return cell
    }
}

//MARK: UISearchResultsUpdating
extension DetailViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
