//
//  APIServiceImpl.swift
//  Networking
//
//  Created by Asqarov Diyorjon on 02/03/25.
//


import Foundation
import Alamofire
import Module

public class APIServiceImpl {
    private let baseURL = "https://jsonplaceholder.typicode.com"

    public init() {}
    
    public func request<T: Decodable>(endpoint: String, method: HTTPMethod, parameters: Encodable? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]

        let request = AF.request(url, method: method, parameters: parameters?.asDictionary(), encoding: JSONEncoding.default, headers: headers)

        request.validate().responseDecodable(of: T.self) { response in
            completion(response.result.mapError { $0 as Error })
        }
    }
}
