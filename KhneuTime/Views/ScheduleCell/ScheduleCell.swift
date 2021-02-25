//
//  ScheduleCell.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class ScheduleCell: UITableViewCell, ReusableCell {
    @IBOutlet weak var nameSubjectLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    
    class var reusableIndentify: String{
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    
    func configure(name: String, type: String, location: String, teacher: String) {
        nameSubjectLabel.text = name
        typeLabel.text = type
        locationLabel.text = location
        teacherLabel.text = teacher
    }
    
}
