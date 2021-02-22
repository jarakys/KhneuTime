//
//  DocumentUIViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 14.02.2021.
//

import UIKit

class DocumentViewController: CoordinableViewController {
    
    var form = FormEnum.document
    
    let dataSources: [UITableViewDataSource & UITableViewDelegate] = []
    
    var selectedDataSource: (UITableViewDataSource & UITableViewDelegate)!
    
    @IBOutlet weak var documentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        documentTableView.delegate = self
        documentTableView.dataSource = self
        
        documentTableView.register(SelectableCell.nib, forCellReuseIdentifier: SelectableCell.reusableIndentify)
        documentTableView.register(FieldCell.nib, forCellReuseIdentifier: FieldCell.reusableIndentify)
        documentTableView.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.reusableIndentify)
        
        selectedDataSource = dataSources[0]
    }

}

extension DocumentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        selectedDataSource.numberOfSections?(in: tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedDataSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        selectedDataSource.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        selectedDataSource.tableView?(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        selectedDataSource.tableView?(tableView, heightForHeaderInSection: section) ?? 0
    }
    
}
