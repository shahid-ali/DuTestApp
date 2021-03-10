//
//  APICall.swift
//  DuTest
//
//  Created by Shahid Ali on 3/10/21.
//  Copyright © 2021 Shahid. All rights reserved.
//

import Alamofire

class APICall {

	//MARK:request, generic function to call the HTTP endpoints and return results and error in closure
	//other options to return results from here may be using observable or Promise
	static func request<T>(_ urlConvertible: URLRequestConvertible,completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        AF.request(urlConvertible).responseData(completionHandler: {response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
                        do {
							completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            print(String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                    default:
                     let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}
