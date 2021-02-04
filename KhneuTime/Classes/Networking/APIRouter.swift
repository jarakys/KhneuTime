//
//  APIRouter.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 04.02.2021.
//

import Foundation

enum APIRouter {
    
    case faculties
    case specialties(facultetId: Int)
    case groups(facultetId: Int,specialitId: Int, course: Int)
    
    private var method: String {
        switch self {
        case .faculties, .specialties, .groups:
            return "GET"
        }
    }
    
    private var path: String {
        switch self {
        case .faculties:
            return "/Faculties"
        case .specialties(let facultetId):
            return ""
        case .groups(let facultetId, let specialitId, let course):
            return ""
        }
    }
    
    private var headers: [String: String]? {
        return ["Content-Type":"application/json", "Accept":"application/json"]
    }
    
    // MARK: - Parameters
    private var parameters: [String:Any]? {
        switch self {
        case .faculties, .specialties, .groups:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: "http://www.dovidkaei.hneu.edu.ua/api/StudentAPI") else {
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
