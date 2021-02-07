//
//  Data+ToDictionary.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 07.02.2021.
//

import Foundation

extension Data {
    func convertToDictionary() -> [[String: Any]]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [[String: Any]]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
