//
//  CoreDataManagerService.swift
//  Persistency
//
//  Created by Asqarov Diyorjon on 03/03/25.
//


import Foundation
import CoreData
import Module

public protocol CoreDataManagerService {
    func saveTodos(_ todos: [Todo])
    func fetchTodos() -> [Todo]
    func saveUsers(_ users: [User])
    func fetchUsers() -> [User]
}

extension CoreDataManager: CoreDataManagerService {
    public func saveTodos(_ todos: [Todo]) {
        clearEntities(entityType: TodoEntity.self)
        
        todos.forEach { todo in
            let todoItem = TodoEntity(context: context)
            todoItem.id = Int64(todo.id)
            todoItem.title = todo.title ?? ""
            todoItem.completed = todo.completed ?? false
            todoItem.userId = Int64(todo.userId ?? 0)
        }
        saveContext()
    }
    
    public func fetchTodos() -> [Todo] {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            return try context.fetch(request).map {
                Todo(id: Int($0.id), title: $0.title ?? "", completed: $0.completed, userId: Int($0.userId))
            }
        } catch {
            print("❌ Failed to fetch todos: \(error.localizedDescription)")
            return []
        }
    }
    
    public func saveUsers(_ users: [User]) {
        clearEntities(entityType: UserEntity.self)
        
        users.forEach { user in
            let userEntity = UserEntity(context: context)
            userEntity.id = Int64(user.id)
            userEntity.name = user.name
            userEntity.username = user.username
            userEntity.email = user.email
            
            if let userAddress = user.address {
                let addressEntity = AddressEntity(context: context)
                addressEntity.street = userAddress.street
                addressEntity.suite = userAddress.suite
                addressEntity.city = userAddress.city
                addressEntity.zipcode = userAddress.zipcode
                
                if let geoData = userAddress.geo {
                    let geoEntity = GeoEntity(context: context)
                    geoEntity.lat = geoData.lat
                    geoEntity.lng = geoData.lng
                    addressEntity.geo = geoEntity
                }
                userEntity.address = addressEntity
            }
        }
        saveContext()
    }
    
    public func fetchUsers() -> [User] {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            return try context.fetch(request).map { userEntity in
                let address = userEntity.address.map { addressEntity in
                    Address(
                        street: addressEntity.street,
                        suite: addressEntity.suite,
                        city: addressEntity.city,
                        zipcode: addressEntity.zipcode,
                        geo: addressEntity.geo.map { Geo(lat: $0.lat, lng: $0.lng) }
                    )
                }
                return User(
                    id: Int(userEntity.id),
                    name: userEntity.name,
                    username: userEntity.username,
                    email: userEntity.email,
                    adddress: address
                )
            }
        } catch {
            print("❌ Failed to fetch users: \(error.localizedDescription)")
            return []
        }
    }
}
