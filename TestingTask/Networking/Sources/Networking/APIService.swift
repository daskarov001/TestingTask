//
//  APIService.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 01/03/25.
//


import Foundation
import Module

public protocol APIService {
    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void)
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

extension APIServiceImpl: APIService {
   
    public func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
        request(endpoint: "/todos", method: .get, completion: completion)
    }

    public func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        request(endpoint: "/users", method: .get, completion: completion)
    }
    
}


