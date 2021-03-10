//
//  NetworkConstant.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

struct NetworkConstants {
    
    /// Base URL
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    /// Parameter Keys
    enum ParameterKey: String {
        // Auth
        case email = "email"
        case password = "password"
    }
    
    /// The keys for HTTP header fields
    enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    /// The values for HTTP header fields
    enum HTTPHeaderFieldValue: String {
        case json = "application/json"
    }
}
