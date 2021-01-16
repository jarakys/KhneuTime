//
//  SpecialtiesViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class SpecialtiesViewController: BaseViewController<String> {
    
    var facultName: String?
    
    override var data: [String] {
        get {
            return ["234343"]
        }
        set {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = facultName
        navigationItem.largeTitleDisplayMode = .always
        //update()
        // Do any additional setup after loading the view.
    }
    

    override func didTap(indexPath: IndexPath) {
        let selectGroupVC: SelectGroupViewController = UIStoryboard.storyboard(storyboard: .groups).instantiateViewController()
        selectGroupVC.specialtyName = "CS"
        navigationController?.pushViewController(selectGroupVC, animated: true)
    }
    
}
