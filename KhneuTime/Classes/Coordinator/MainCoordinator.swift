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
        let transition = PanelTransition(height: 300)
        detailVC.transitioningDelegate = transition
        detailVC.modalPresentationStyle = .custom
        currentVC?.present(detailVC, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String, actiions: [String], callback: @escaping (String) -> Void) {
        currentVC?.presentAlert(withTitle: title, message: message, actions: actiions, callback: callback)
    }
    
    func hideAlert() {
        if currentVC?.presentedViewController is UIAlertController {
            currentVC?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func openSchedule(for group: GroupDB) {
        let storyboard = UIStoryboard.storyboard(storyboard: .main)
        let scheduleVC: ScheduleViewController = storyboard.instantiateViewController()
        scheduleVC.group = group
        scheduleVC.coordinator = self
        (tabBarController.selectedViewController as? UINavigationController)?.pushViewController(scheduleVC, animated: true)
    }
    
    func openCalendar(selectedDate: Date, doneAction: @escaping (Date) -> Void) {
        let storyboard = UIStoryboard.storyboard(storyboard: .main)
        let calendarVC: CalendarViewController = storyboard.instantiateViewController()
        calendarVC.doneAction = doneAction
        calendarVC.initDate = selectedDate
        calendarVC.selectedDate = selectedDate
        let transition = PanelTransition(height: 350)
        calendarVC.transitioningDelegate = transition
        calendarVC.modalPresentationStyle = .custom
        currentVC?.present(calendarVC, animated: true, completion: nil)
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
