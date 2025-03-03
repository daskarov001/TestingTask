//
//  AppNavigation.swift
//  TestingTask
//
//  Created by Asqarov Diyorjon on 01/03/25.
//


import UIKit
import MainScreen
import Swinject
import Module

final class AppNavigation: NavigationService, MainNavigationService {
    var navigationController: UINavigationController
    var diContainer: Container
    init(navigationController: UINavigationController, diContainer: Container) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func instantiateTodosView() {
        let todosViewModel = diContainer.resolve(TodosViewModel.self)!
        let todosViewController = TodosViewController(viewModel: todosViewModel)
        navigationController.show(todosViewController, sender: nil)
    }
    
    func openDetailView(_ todoWithUser: TodoWithUser) {
        let todoDetailsViewModel = diContainer.resolve(TodoDetailsViewModel.self, argument: todoWithUser)!
        let todoDetailsViewController = TodoDetailsViewController(viewModel: todoDetailsViewModel)
        navigationController.pushViewController(todoDetailsViewController, animated: true)
    }
}



