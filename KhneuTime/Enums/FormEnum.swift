//
//  FormEnum.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 14.02.2021.
//

import Foundation

enum Document: String, CaseIterable {
    case name = "name"
    case email = "email"
    case facultyId = "facultyId"
    case specialtyId = "specialtyId"
    case destination = "destination"
    case studentTypeId = "studentTypeId"
    
    var description: String {
        switch self {
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .facultyId:
            return "Faculty"
        case .specialtyId:
            return "Specialty"
        case .destination:
            return "Destination"
        case .studentTypeId:
            return "Student Type"
        }
    }
    
    var formType: FormEnum {
        return .document
    }
}

enum ReportDocument: String, CaseIterable {
    case name = "name"
    case reportType = "reportType"
    case facultyId = "facultyId"
    case specialtyId = "specialtyId"
    case course = "course"
    case file = "file"
    
    var description: String {
        switch self {
        case .name:
            return "Name"
        case .reportType:
            return "Report Type"
        case .facultyId:
            return "Faculty"
        case .specialtyId:
            return "Specialty"
        case .course:
            return "Course"
        case .file:
            return "File"
        }
    }
    
    var formType: FormEnum {
        return .reportDocument
    }
}

enum ExtramuralDocument: String, CaseIterable {
    case facultyId = "facultyId"
    case specialtyId = "specialtyId"
    case student = "student"
    
    var description: String {
        switch self {
        case .facultyId:
            return "Faculty"
        case .specialtyId:
            return "Specialty"
        case .student:
            return "Student"
        }
    }
    
    var formType: FormEnum {
        return .extramuralDocument
    }
    
}

enum FormEnum: Int, RawRepresentable {
    case document
    case reportDocument
    case extramuralDocument
    
    var description: String {
        switch self {
        case .document:
            return "Документ с места учебы"
        case .reportDocument:
            return "Отчет об оплате"
        case .extramuralDocument:
            return "Допуск к сессии(заочная фомра обучения)"
        }
    }
    
    func apiRoute(body: Dictionary<String, Any>) -> APIRouter {
        switch self {
        case .document:
            return .document(facultyId: body["facultyId"] as! Int, specialtyId: body["specialtyId"] as! Int, groupId: body["groupId"] as! Int, studentTypeId: body["studentTypeId"] as! Int, studentName: body["studentName"] as! String, email: body["email"] as! String, destination: body["destination"] as! String)
        default:
            return .groups
        }
    }
}

extension FormEnum: DetailedModelProtocol {
    var idDetailed: Int {
        return self.rawValue
    }
    
    var nameDetailed: String {
        return self.description
    }
}
