//
//  Todo.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 01/03/25.
//


public struct Todo: Codable {
    public let id: Int
    public let title: String?
    public let completed: Bool?
    public let userId: Int?
    
    public init(id: Int, title: String?, completed: Bool?, userId: Int?) {
        self.id = id
        self.title = title
        self.completed = completed
        self.userId = userId
    }
}
