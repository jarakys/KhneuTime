//
//  Coordinator.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var tabBarController: UITabBarController { get set }
    
    func initVCs()
    
    func startConfigureGroupVC()
    func startConfigureTeacherVC()
    
    func startSelectFaculty()
    func startSelectSpecialty()
    func startSelectGroup()
    
}
