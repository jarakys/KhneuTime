//
//  DataSourceDelegate.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 15.01.2021.
//

import UIKit

class DataSourceDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
