//
//  TodosViewModel.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 01/03/25.
//

import Foundation
import Module

public class TodosViewModel {
    private let todoRepository: TodoRepository
    public let navigationService: NavigationService

    private(set) var todosWithUser: [TodoWithUser] = []
    public var filteredTodosWithUser: [TodoWithUser] = []
    private var currentPage = 0
    private let itemsPerPage = 20
    private var query = ""
    public var onUpdate: (() -> Void)?

    public init(todoRepository: TodoRepository, navigationService: NavigationService) {
        self.todoRepository = todoRepository
        self.navigationService = navigationService
    }

    public func loadTodos() {
        todoRepository.fetchTodosWithUsers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let todosWithUser):
                self.todosWithUser = todosWithUser
                self.filteredTodosWithUser = Array(todosWithUser.prefix(self.itemsPerPage))
                self.onUpdate?()
            case .failure(let error):
                print("Error fetching todos: \(error.localizedDescription)")
            }
        }
    }

    public func loadMoreTodos() {
        guard query.isEmpty else { return }
        
        let nextPage = currentPage + 1
        let startIndex = nextPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, todosWithUser.count)
        
        if startIndex < todosWithUser.count {
            filteredTodosWithUser.append(contentsOf: todosWithUser[startIndex..<endIndex])
            currentPage = nextPage
            onUpdate?()
        }
    }

    public func searchTodos(query: String) {
        self.query = query
        if query.isEmpty {
            filteredTodosWithUser = Array(todosWithUser.prefix(itemsPerPage))
        } else {
            filteredTodosWithUser = todosWithUser.filter({ todoWithUser in
                let enabledByTitle = todoWithUser.todo.title?.lowercased().contains(query.lowercased()) ?? false
                let enabledByUserName = todoWithUser.user?.username?.lowercased().contains(query.lowercased()) ?? false
                
                return (enabledByTitle || enabledByUserName)
            })
        }
        onUpdate?()
    }
    
    func openDetailView(_ indexPath: IndexPath) {
        navigationService.openDetailView(filteredTodosWithUser[indexPath.row])
    }
}
