//
//  APIRouter.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // MARK: - Endpoints
    case getPosts
    case getPostDetails(id: Int)
    case signIn(email: String, password: String)
  
    // MARK: - Properties
    private var method: HTTPMethod {
        switch self {
        case .getPosts,
             .getPostDetails:
            return .get
        case .signIn:
            return .post
        }
    }
  
    private var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        case .getPostDetails(let id):
            return "/posts/\(id)"
        case .signIn:
            return "api/auth/login"
        }
    }
  
    private var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    private var body: Parameters? {
        switch self {
        case .signIn(let email, let password):
            return [NetworkConstants.ParameterKey.email.rawValue: email,
                    NetworkConstants.ParameterKey.password.rawValue: password]
        default:
            return nil
        }
    }
    
    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        // Construct url
        let url = try NetworkConstants.baseURL.asURL()
        
        // Append path
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Determine HTTP method
        urlRequest.httpMethod = method.rawValue
        
        // Set common headers
        urlRequest.setValue(NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
                            forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.acceptType.rawValue)
        urlRequest.setValue(NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
                            forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.contentType.rawValue)
        
        // Add http body to request
        if let body = body {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = data
            } catch (_) {
                print("APIRouter: Failed to parse body into request.")
            }
        }
        
        // Add query parameters to request
        if let parameters = parameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
