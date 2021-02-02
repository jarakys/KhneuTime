//
//  DataRepository.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 02.02.2021.
//

import Foundation

class DataRepository {
    
    static let shared = DataRepository()
    
    private init() { }
    
    func loadSchedule(groupId: String, specialtyId: String, completion: @escaping(Bool) -> Void) {
        //Alamofire layer
        DatabaseManager.sharder.insertOrUpdateSchedule(groupId: groupId, specialtyId: specialtyId, completion: completion)
    }
}
