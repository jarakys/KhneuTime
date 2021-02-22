//
//  ConfigureGroupViewModel.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 21.02.2021.
//

import Foundation

class ConfigureGroupViewModel {
    
    @Binding
    public var nodes = [SettingNode]()
    
    let state: State
    private let dataSource: ConfigureGroupDataSource
    
    init(dataSource: ConfigureGroupDataSource) {
        self.dataSource = dataSource
        state = State(dataSource: dataSource)
    }
    
    func setup() {
        prepareState()
        composeNodes()
    }
    
    func prepareState() {
        state.facultyState.$id.subscribe(self, callback: {[weak self] value in
            self?.updateDataSourceProperty(\.selectedFaculty, with: value)
            self?.composeNodes()
        })
        
        state.specialtyState.$id.subscribe(self, callback: {[weak self] value in
            self?.updateDataSourceProperty(\.selectedSpecialty, with: value)
            self?.composeNodes()
        })
        
        state.courseState.$id.subscribe(self, callback: {[weak self] value in
            self?.updateDataSourceProperty(\.selectedCourse, with: value)
        })
        
        state.groupsState.$values.subscribe(self, callback: {[weak self] values in
            self?.updateDataSourceProperty(\.selectedGroups, with: values)
            self?.composeNodes()
        })
    }
    
    func composeNodes() {
        let facultyNode = SelectableDropdownNode(title: "Faculty", placeholder: dataSource.facultyPlaceholder, options: dataSource.faculties, state: state.facultyState)
        let specialtyNode = SelectableDropdownNode(title: "Specialty", placeholder: dataSource.specialtyPlaceholder, options: dataSource.specialties(facultyId: dataSource.selectedFaculty), state: state.specialtyState)
        let courseNode = SelectableDropdownNode(title: "Course", placeholder: dataSource.defaultCourse.description, options: dataSource.courses, state: state.courseState)
        var groups = [SettingNode]()
        for group in dataSource.groups(speacialtyId: dataSource.selectedSpecialty, course: dataSource.selectedCourse) {
            groups.append(SelectableGroupNode(title: group.name ?? "", id: Int(group.id), state: state.groupsState))
        }
        nodes = [facultyNode, specialtyNode, courseNode, LabelSeparator(title: "Groups")]
        nodes.append(contentsOf: groups)
    }
    
    private func updateDataSourceProperty<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<ConfigureGroupDataSource, T>,
                                                        with value: T,
                                                        completedBlock: (() -> Void)? = nil) {
        dataSource[keyPath: keyPath] = value
    }
}
