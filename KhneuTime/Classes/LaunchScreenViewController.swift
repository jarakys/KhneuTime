//
//  LaunchScreenViewController.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 08.03.2021.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SyncManager.shared.startInit {
            PrefsManager.shared.set(pref: .notFirstLaunch, value: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
