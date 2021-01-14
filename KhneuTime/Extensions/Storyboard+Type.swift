//
//  Storyboard+Type.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case main
        case groups
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    func instantiateViewController<T: UIViewController>() -> T  {
        guard let viewController = self.instantiateViewController(withIdentifier: T.className) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.className) ")
        }
        
        return viewController
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
}
