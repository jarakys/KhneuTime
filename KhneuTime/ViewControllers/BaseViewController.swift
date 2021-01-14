//
//  BaseViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

class BaseViewController<T>: UIViewController, TableViewControllerDelegate {
    
    var warningView: TextAlertView?
    var tableViewController: TableViewController<T>?
    var data:[T] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        if data.isEmpty {
            warningView = warningView ?? TextAlertView()
            warningView?.frame = view.frame
            warningView?.actionButton.target(forAction: #selector(addDidTap(_:)), withSender: self)
            warningView?.warningTitileLabel.text = "У вас еще нет расписания. Используйте нижнюю панель навигации, чтобы добавить группу или преподавателя."
            guard let warningView = warningView else { return }
            view.addSubview(warningView)
        } else {
            warningView?.removeFromSuperview()
            tableViewController = tableViewController ?? TableViewController<T>()
            tableViewController?.items = data
            tableViewController?.reusableCell = TableCell()
            tableViewController?.delegate = self
            guard let vc = tableViewController else { return }
            vc.removeFromParent()
            addChild(vc)
            vc.view.frame = view.safeAreaLayoutGuide.layoutFrame
            vc.view.removeFromSuperview()
            view.addSubview(vc.view)
        }
        navigationItem.largeTitleDisplayMode = .always
    }
    
    @objc func addDidTap(_ sender: UIButton) {
        print("sdsdsd")
    }
    
    func didTap(indexPath: IndexPath) {
    }
}
