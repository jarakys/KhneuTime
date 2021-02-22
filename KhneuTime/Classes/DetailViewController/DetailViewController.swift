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
    
    var didClose: ((DetailedModelProtocol?) -> Void)?
    
    var data = [DetailedModelProtocol]()
    
    var selectedData: DetailedModelProtocol?
    var closeOnClick = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        detailsViewController.delegate = self
        detailsViewController.dataSource = self
        detailsViewController.register(DetailedCell.nib, forCellReuseIdentifier: DetailedCell.reusableIndentify)
        searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func cancelDidTap(_ sender: Any) {
        selectedData = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDidTap(_ sender: Any?) {
        didClose?(selectedData)
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailedCell.reusableIndentify, for: indexPath) as! DetailedCell
        cell.configure(data: data[indexPath.row])
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedData = data[indexPath.row]
        if closeOnClick { saveDidTap(nil) }
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
