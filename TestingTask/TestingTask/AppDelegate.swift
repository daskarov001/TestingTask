//
//  AppDelegate.swift
//  TestingTask
//
//  Created by Asqarov Diyorjon on 01/03/25.
//

import UIKit
import Swinject
import MainScreen
import Module
import Networking
import Persistency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appNavigationService: AppNavigation?
    let container = Container()
    var navigationController: UINavigationController = .init()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        navigationController = .init()
        window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        registerDependencies()
        registerViewModels()
       
        let appNavigation = container.resolve(NavigationService.self)!
        appNavigation.instantiateTodosView()
        
        return true
    }
    
    private func registerDependencies() {
        container.register(NavigationService.self) { [weak self] _ in
            AppNavigation(navigationController: self!.navigationController, diContainer: self!.container)
        }
        
        container.register(CoreDataManagerService.self) { _ in
            CoreDataManager()
        }
        
        container.register(APIService.self) { _ in
            APIServiceImpl()
        }
        
        container.register(TodoRepository.self) { resolver in
            let apiService = resolver.resolve(APIService.self)!
            let coreDataService = resolver.resolve(CoreDataManagerService.self)!
            return TodoRepositoryImpl(apiService: apiService, coreDataManagerService: coreDataService)
        }
    }


    private func registerViewModels() {
        container.register(TodosViewModel.self) { resolver in
            let todoRepository = resolver.resolve(TodoRepository.self)!
            let navigationService = resolver.resolve(NavigationService.self)!
            return TodosViewModel(todoRepository: todoRepository, navigationService: navigationService)
        }
        
        container.register(TodoDetailsViewModel.self) { (resolver, todoWithUser: TodoWithUser) in
            return TodoDetailsViewModel(todoWithUser: todoWithUser)
        }
    }
}

