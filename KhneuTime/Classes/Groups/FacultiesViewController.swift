//
//  FacultiesViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class FacultiesViewController: UIViewController {
    @IBOutlet weak var groupsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
