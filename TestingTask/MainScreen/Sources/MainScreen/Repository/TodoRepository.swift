//
//  TodoRepository.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 01/03/25.
//


import Foundation
import Module
import Networking
import Persistency

public protocol TodoRepository {
    func fetchTodosWithUsers(completion: @escaping (Result<[TodoWithUser], Error>) -> Void)
}

public class TodoRepositoryImpl: TodoRepository {
    private let apiService: APIService
    private let coreDataManagerService: CoreDataManagerService
    
    public init(apiService: APIService, coreDataManagerService: CoreDataManagerService) {
        self.apiService = apiService
        self.coreDataManagerService = coreDataManagerService
    }
    
    public func fetchTodosWithUsers(completion: @escaping (Result<[TodoWithUser], Error>) -> Void) {
        let group = DispatchGroup()
        var todos: [Todo] = []
        var users: [User] = []
        
        group.enter()
        apiService.fetchTodos { result in
            if case .success(let fetchedTodos) = result {
                todos = fetchedTodos
                self.coreDataManagerService.saveTodos(fetchedTodos)
            } else {
                todos = self.coreDataManagerService.fetchTodos()
            }
            group.leave()
        }
        
        group.enter()
        apiService.fetchUsers { result in
            if case .success(let fetchedUsers) = result {
                users = fetchedUsers
                self.coreDataManagerService.saveUsers(fetchedUsers)
            } else {
                users = self.coreDataManagerService.fetchUsers()
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            let mappedTodos = todos.map { todo in
                TodoWithUser(todo: todo, user: users.first { $0.id == todo.userId })
            }
            completion(.success(mappedTodos))
        }
    }
}
