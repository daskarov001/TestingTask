//
//  NavigationService.swift
//  TestingTask
//
//  Created by Asqarov Diyorjon on 01/03/25.
//


import UIKit

public protocol NavigationService: MainNavigationService {
    var navigationController: UINavigationController { get set }
    func popToRootViewController(animated: Bool)
    func instantiateTodosView()
}

public protocol MainNavigationService {
    func openDetailView(_ todoWithUser: TodoWithUser)
}
