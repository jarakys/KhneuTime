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
    
    var data = [DetailedModelProtocol]() {
        didSet {
            searchedData = data
        }
    }
    
    private var searchedData = [DetailedModelProtocol]()
    
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
        searchedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailedCell.reusableIndentify, for: indexPath) as! DetailedCell
        cell.configure(data: searchedData[indexPath.row])
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedData = searchedData[indexPath.row]
        if closeOnClick { saveDidTap(nil) }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}

// MARK: UISearchBarDelegate {
extension DetailViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedData = data
        detailsViewController.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchText.trimmingCharacters(in: .whitespaces).count == 0 {
            searchedData = data
        } else {
            searchedData = data.filter({ $0.nameDetailed.contains(searchText)} )
        }
        detailsViewController.reloadData()
    }
}
