//
//  MainCoordinator.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var tabBarController: UITabBarController
    weak var currentVC: UIViewController?

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func initVCs() {
        tabBarController.viewControllers?.forEach({ vc in
            ((vc as? UINavigationController)?.topViewController as? CoordinableViewController)?.coordinator = self
        })
    }
    
    func startConfigureGroupVC() {
        let storyboard = UIStoryboard.storyboard(storyboard: .groups)
        let groupVC: FacultiesViewController = storyboard.instantiateViewController()
        groupVC.coordinator = self
        (tabBarController.selectedViewController as? UINavigationController)?.pushViewController(groupVC, animated: true)
    }
    
    func startSelectableDetail(data: [String], completion: @escaping(String) -> Void) {
        let storyboard = UIStoryboard.storyboard(storyboard: .groups)
        let detailVC: DetailViewController = storyboard.instantiateViewController()
        detailVC.didClose = completion
        currentVC?.present(detailVC, animated: true, completion: nil)
    }
    
    func startConfigureTeacherVC() {
    }
    
    func startSelectFaculty() {
    }
    
    func startSelectSpecialty() {
    }
    
    func startSelectGroup() {
    }
}
