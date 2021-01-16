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
        (tabBarController.selectedViewController as? UINavigationController)?.pushViewController(groupVC, animated: true)
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
