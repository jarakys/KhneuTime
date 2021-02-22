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
    
    func startSelectableDetail(data: [DetailedModelProtocol], completion: @escaping(DetailedModelProtocol?) -> Void) {
        let storyboard = UIStoryboard.storyboard(storyboard: .groups)
        let detailVC: DetailViewController = storyboard.instantiateViewController()
        detailVC.didClose = completion
        detailVC.data = data
        currentVC?.present(detailVC, animated: true, completion: nil)
    }
    
    func startSelectableCourse(data: [DetailedModelProtocol], completion: @escaping (DetailedModelProtocol?) -> Void) {
        let storyboard = UIStoryboard.storyboard(storyboard: .groups)
        let detailVC: CourseViewController = storyboard.instantiateViewController()
        detailVC.didClose = completion
        detailVC.data = data
        let transition = PanelTransition()
        detailVC.transitioningDelegate = transition
        detailVC.modalPresentationStyle = .custom
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
