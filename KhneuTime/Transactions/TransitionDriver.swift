//
//  TransitionDriver.swift
//  MacronCRM
//
//  Created by Kyrylo Chernov on 05.10.2020.
//  Copyright © 2020 Macron. All rights reserved.
//

import UIKit

class TransitionDriver: UIPercentDrivenInteractiveTransition {
    func link(to controller: UIViewController) {
        presentedController = controller
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer!)
    }

    private var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?
    
    override var wantsInteractiveStart: Bool {
        get {
            let gestureIsActive = panRecognizer?.state == .began
            return gestureIsActive
        }

        set { }
    }
    
    var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }
      
    @objc private func handle(recognizer r: UIPanGestureRecognizer) {
        handleDismiss(recognizer: r)
    }
    
    private func handleDismiss(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause() // Без паузы percentComplete всегда равен 0

            let isRunning = percentComplete != 0
            if !isRunning {
                presentedController?.dismiss(animated: true, completion: nil)
            }

        case .changed:
            update(percentComplete + r.incrementToBottom(maxTranslation: maxTranslation))

        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }

        case .failed:
            cancel()

        default:
            break
        }
    }
    
}
