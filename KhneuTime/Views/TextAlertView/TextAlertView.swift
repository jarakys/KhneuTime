//
//  TextAlertView.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class TextAlertView: UIView {
    
    @IBOutlet weak var warningTitileLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupXib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = frame
    }
    
    private func setupXib() {
        contentView = Bundle.main.loadNibNamed("TextAlertView", owner: self, options: nil)![0] as? UIView
        contentView.frame = frame
        addSubview(contentView)
    }
    
}
