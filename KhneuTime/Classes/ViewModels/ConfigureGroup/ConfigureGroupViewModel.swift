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
    private let coordinator: Coordinator
    
    init(dataSource: ConfigureGroupDataSource, coordinator: Coordinator) {
        self.dataSource = dataSource
        self.coordinator = coordinator
        state = State(dataSource: dataSource)
    }
    
    func setup() {
        prepareState()
        composeNodes()
    }
    
    func prepareState() {
        state.facultyState.$id.subscribe(self, callback: {[weak self] value in
            self?.updateDataSourceProperty(\.selectedFaculty, with: value)
            self?.state.specialtyState.reset()
            self?.composeNodes()
        })
        
        state.specialtyState.$id.subscribe(self, callback: {[weak self] value in
            self?.updateDataSourceProperty(\.selectedSpecialty, with: value)
            self?.composeNodes()
        })
        
        state.courseState.$id.subscribe(self, callback: {[weak self] value in
            self?.updateDataSourceProperty(\.selectedCourse, with: value)
            self?.composeNodes()
        })
        
        state.groupsState.$values.subscribe(self, callback: {[weak self] values in
            guard let self = self else { return }
            let differences = values.difference(from: self.dataSource.selectedGroups)
            for difference in differences {
                switch difference {
                case .remove(_, let element, _):
                    SyncManager.shared.removeSchedule(for: element)
                    
                case .insert(_, let element, _):
                    self.coordinator.presentAlert(title: "Waiting", message: "Update schedule", actiions: [], callback: {_ in })
                    SyncManager.shared.setSchedule(for: element, completion: {success in
                        self.coordinator.hideAlert()
                    })
                }
            }
            self.updateDataSourceProperty(\.selectedGroups, with: values)
            self.composeNodes()
        })
    }
    
    func composeNodes() {
        let facultyNode = SelectableDropdownNode(title: "Faculty", placeholder: dataSource.facultyPlaceholder, options: dataSource.faculties, state: state.facultyState, didTapAction: {[weak self] in
            guard let self = self else { return }
            self.coordinator.startSelectableDetail(data: self.dataSource.faculties, completion: {result in
                guard let detailedData = result else { return }
                self.state.facultyState.id = detailedData.idDetailed
                self.state.facultyState.value = detailedData.nameDetailed
            })
        })
        let specialtyNode = SelectableDropdownNode(title: "Specialty", placeholder: dataSource.specialtyPlaceholder, options: dataSource.specialties(facultyId: dataSource.selectedFaculty), state: state.specialtyState, didTapAction: {[weak self] in
            guard let self = self else { return }
            self.coordinator.startSelectableDetail(data: self.dataSource.specialties(facultyId: self.dataSource.selectedFaculty), completion: {result in
                guard let detailedData = result else { return }
                self.state.specialtyState.id = detailedData.idDetailed
                self.state.specialtyState.value = detailedData.nameDetailed
            })
        })
        let courseNode = SelectableDropdownNode(title: "Course", placeholder: dataSource.defaultCourse.description, options: dataSource.courses, state: state.courseState, didTapAction: {[weak self] in
            guard let self = self else { return }
            self.coordinator.startSelectableCourse(data: self.dataSource.courses, completion: {result in
                guard let detailedData = result else { return }
                self.state.courseState.id = detailedData.idDetailed
                self.state.courseState.value = detailedData.nameDetailed
            })
        })
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
