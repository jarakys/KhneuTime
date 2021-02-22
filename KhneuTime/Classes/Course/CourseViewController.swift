//
//  CourseViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 22.02.2021.
//

import UIKit

class CourseViewController: UIViewController {

    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var decoratorView: UIView!
    
    var didClose: ((DetailedModelProtocol?) -> Void)?
    var data = [DetailedModelProtocol]()
    var selectedData: DetailedModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coursePicker.delegate = self
        coursePicker.dataSource = self
        decoratorView.layer.cornerRadius = 6
    }
}

//MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension CourseViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        4
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        (row + 1).description
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedData = row + 1
        didClose?(selectedData)
        dismiss(animated: true, completion: nil)
    }
}

