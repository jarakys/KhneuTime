//
//  APIRouter.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 04.02.2021.
//

import Foundation

enum APIRouter {
    
    case faculties
    case specialties
    case groups
    case shedule(groupId: Int)
    case studentTypes
    case document(facultyId: Int, specialtyId: Int, groupId: Int, studentTypeId: Int, studentName: String, email: String, destination: String)
    
    private var method: String {
        switch self {
        case .faculties, .specialties, .groups, .shedule, .studentTypes:
            return "GET"
        case .document:
            return "POST"
        }
    }
    
    private var path: String {
        switch self {
        case .faculties:
            return "/Faculties"
        case .specialties:
            return "/Specialties"
        case .groups:
            return "/AllGroups"
        case .studentTypes:
            return "/StudentTypes"
        case .shedule(let groupId):
            return "/Schedule?groupId=\(groupId)"
        case  .document:
            return ""
        }
    }
    
    private var headers: [String: String]? {
        return ["Content-Type":"application/json", "Accept":"application/json"]
    }
    
    // MARK: - Parameters
    private var parameters: [String:Any]? {
        switch self {
        case .faculties, .specialties, .groups, .shedule, .studentTypes:
            return nil
        case let .document(facultyId, specialtyId, groupId, studentTypeId, studentName, email, destination):
            return ["FIO":studentName,
                    "SpecialtyId": specialtyId,
                    "GroupId": groupId,
                    "Destination": destination,
                    "EmailAddress": email,
                    "StudentTypeId": studentTypeId]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: "http://www.dovidkaei.hneu.edu.ua/api/main" + path) else {
            throw URLError(URLError.Code.unsupportedURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch  {
                
            }
        }
        return urlRequest
    }
}
