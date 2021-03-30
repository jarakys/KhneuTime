//
//  NoSwipeCollectionView.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 05.03.2021.
//

import UIKit

class SwipableCollectionView: UICollectionView, UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
