//
//  UIView+addBlur.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 09.02.2021.
//

import UIKit

extension UIView {
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: frame.origin.x, y: 0, width: frame.size.width, height: frame.size.height)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = true
        addSubview(blurEffectView)
    }
}
