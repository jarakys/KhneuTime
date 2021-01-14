//
//  GroupsViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class GroupsViewController: BaseViewController<String> {
    
    override var data: [String] {
        get {
            return ["HUI"]
        }
        set {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func navigateToFaculties() {
        let facultisVC: FacultiesViewController = UIStoryboard.storyboard(storyboard: .groups).instantiateViewController()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.pushViewController(facultisVC, animated: true)
    }
    
    @IBAction func addBarButtonDidTap(_ sender: Any) {
        navigateToFaculties()
    }
    
    @objc override func addDidTap(_ sender: UIButton) {
        navigateToFaculties()
    }
    
    
}
