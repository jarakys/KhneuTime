//
//  ScheduleViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var scheduleCollectionView: UICollectionView!
    var schedules:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleCollectionView.delegate = self
        scheduleCollectionView.dataSource = self
        scheduleCollectionView.register(ScheduleCell.nib, forCellWithReuseIdentifier: ScheduleCell.reusableIndentify)
    }
}

extension ScheduleViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reusableIndentify, for: indexPath)
        if let scheduleCell = cell as? ScheduleCell {
            scheduleCell.configure(name: "Kirill", type: "Lab ", location: "48L", teacher: "Petux")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height / 7 )
    }
}
