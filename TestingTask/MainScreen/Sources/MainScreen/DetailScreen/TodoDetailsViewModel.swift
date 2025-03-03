//
//  TodoDetailsViewModel.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 03/03/25.
//

import Foundation
import Module

public class TodoDetailsViewModel {
    private let todoWithUser: TodoWithUser
    var onUpdate: (() -> Void)?
    
    private(set) var detailSections: [[DetailItem]] = []

    public init(todoWithUser: TodoWithUser) {
        self.todoWithUser = todoWithUser
        configureData()
    }
    
    private func configureData() {
        let todo = todoWithUser.todo
        let user = todoWithUser.user
        
        detailSections = [
            [
                DetailItem(title: "Title", value: todo.title ?? "No Title"),
                DetailItem(title: "Completed", value: todo.completed == true ? "✅ Yes" : "❌ No")
            ],
            [
                DetailItem(title: "Name", value: user?.name ?? "Unknown"),
                DetailItem(title: "Username", value: user?.username ?? "Unknown"),
                DetailItem(title: "Email", value: user?.email ?? "Unknown")
            ],
            [
                DetailItem(title: "Street", value: user?.adddress?.street ?? "N/A"),
                DetailItem(title: "Suite", value: user?.adddress?.suite ?? "N/A"),
                DetailItem(title: "City", value: user?.adddress?.city ?? "N/A"),
                DetailItem(title: "Zipcode", value: user?.adddress?.zipcode ?? "N/A")
            ],
            [
                DetailItem(title: "Latitude", value: user?.adddress?.geo?.lat ?? "N/A"),
                DetailItem(title: "Longitude", value: user?.adddress?.geo?.lng ?? "N/A")
            ]
        ]
        
        onUpdate?()
    }
}
