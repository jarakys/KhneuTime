//
//  DetailViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 22.01.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailsViewController: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var didClose: ((String) -> Void)?
    
    var data = [DetailedModelProtocol]()
    
    var selectedData: DetailedModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        detailsViewController.delegate = self
        detailsViewController.dataSource = self
        detailsViewController.register(FacultyCell.nib, forCellReuseIdentifier: FacultyCell.reusableIndentify)
        searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        didClose?(selectedData?.nameDetailed ?? "")
    }
    
    @IBAction func cancelDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        cell.configure(title: model.nameDetailed, cellType: .faculty)
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedData = data[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}

//MARK: UISearchResultsUpdating
extension DetailViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: UISearchBarDelegate {
extension DetailViewController: UISearchBarDelegate {
    
}
