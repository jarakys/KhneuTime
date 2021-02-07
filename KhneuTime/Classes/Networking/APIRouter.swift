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
    
    private var method: String {
        switch self {
        case .faculties, .specialties, .groups, .shedule:
            return "GET"
        }
    }
    
    private var path: String {
        switch self {
        case .faculties:
            return "/Faculties"
        case .specialties:
            return ""
        case .groups:
            return ""
        case .shedule(let groupId):
            return ""
        }
    }
    
    private var headers: [String: String]? {
        return ["Content-Type":"application/json", "Accept":"application/json"]
    }
    
    // MARK: - Parameters
    private var parameters: [String:Any]? {
        switch self {
        case .faculties, .specialties, .groups, .shedule:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: "http://www.dovidkaei.hneu.edu.ua/api/StudentAPI" + path) else {
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
