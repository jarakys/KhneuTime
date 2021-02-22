//
//  RoundedGroupCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 16.01.2021.
//

import UIKit

class RoundedGroupCell: UITableViewCell {
    
    var top = false
    var bottom = false

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !top && !bottom {
            layer.mask = nil
            return
        }

        if top && bottom {
            layer.cornerRadius = 10
            layer.masksToBounds = true
            return
        }

        let shape = CAShapeLayer()
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.size.height)
        let corners: UIRectCorner = self.top ? [.topLeft, .topRight] : [.bottomRight, .bottomLeft]

        shape.path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 10, height: 10)).cgPath
        layer.mask = shape
        layer.masksToBounds = true
      }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        top = false
        bottom = false
    }

}
