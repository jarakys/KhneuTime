//
//  ConfigureGroupDataSource.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 21.02.2021.
//

import Foundation

protocol DataSource: class {
    func numberOfRows(in section: Int) -> Int
}

class ConfigureGroupDataSource {
    
    func numberOfRows(in section: Int) -> Int {
        return 3
    }
    
    public var faculties: [FacultyDB] {
        DatabaseManager.shared.getFaculties()
    }
    
    public func specialties(facultyId: Int) -> [SpecialtyDB] {
        DatabaseManager.shared.getSpecialties(facultyId: facultyId)
    }
    
    public func groups(speacialtyId: Int, course: Int) -> [GroupDB] {
        DatabaseManager.shared.getGroups(specialtyId: speacialtyId, course: course)
    }
    
    public var courses: [Int] {
        Array(1...4)
    }
    
    public var selectedFaculty = 1
    public var selectedSpecialty = 1
    public var selectedCourse = 1
    public var selectedGroups: [Int] {
        get { PrefsManager.shared.get(pref: .selectedGroups) ?? [] }
        set {
            PrefsManager.shared.set(pref: .selectedGroups, value: newValue)
        }
    }
}

extension ConfigureGroupDataSource {
    
    public var facultyPlaceholder: String {
        "Select faculty"
    }
    
    public var specialtyPlaceholder: String {
        "Select specialty"
    }
    
    public var groupPlaceholder: String {
        "Select group"
    }
    
    public var defaultCourse: Int {
        1
    }
}
