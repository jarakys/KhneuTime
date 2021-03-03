//
//  PanelTransition.swift
//  MacronCRM
//
//  Created by Kyrylo Chernov on 05.10.2020.
//  Copyright © 2020 Macron. All rights reserved.
//

import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    private let driver = TransitionDriver()
    
    var height: CGFloat = 300
    
    init(height: CGFloat) {
        super.init()
        self.height = height
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        driver.link(to: presented)
        return PresentationController(presentedViewController: presented,
                                      presentingViewController: presenting ?? source, height: height)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
}
