//
//  TodoWithUser.swift
//  CoreModule
//
//  Created by Asqarov Diyorjon on 03/03/25.
//


public struct TodoWithUser {
    public let todo: Todo
    public let user: User?
    
    public init(todo: Todo, user: User?) {
        self.todo = todo
        self.user = user
    }
}
