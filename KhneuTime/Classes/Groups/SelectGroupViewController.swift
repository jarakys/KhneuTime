//
//  SelectGroupViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class SelectGroupViewController: BaseViewController<String> {
    
    var specialtyName: String?
    
    override var data: [String] {
        get {
            return ["6.0.8.44"]
        }
        set {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = specialtyName
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func didTap(indexPath: IndexPath) {
        
    }
    
}
