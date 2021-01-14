//
//  FacultiesViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class FacultiesViewController: BaseViewController<String> {
    
    override var data: [String] {
        get {
            return ["Faculties"]
        }
        set {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Факультеты"
        //update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController!.navigationItem.largeTitleDisplayMode = .never
        navigationItem.largeTitleDisplayMode = .always
    }
    
    @objc override func addDidTap(_ sender: UIButton) {
        let facultisVC: FacultiesViewController = UIStoryboard.storyboard(storyboard: .groups).instantiateViewController()
        navigationController?.pushViewController(facultisVC, animated: true)
    }
    
    override func didTap(indexPath: IndexPath) {
        let specialtiesVC: SpecialtiesViewController = UIStoryboard.storyboard(storyboard: .groups).instantiateViewController()
        specialtiesVC.facultName = "ЭИ"
        navigationController?.pushViewController(specialtiesVC, animated: true)
    }
    
}
