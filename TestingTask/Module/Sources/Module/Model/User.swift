//
//  User.swift
//  MainScreen
//
//  Created by Asqarov Diyorjon on 01/03/25.
//


public struct User: Codable {
    public let id: Int
    public let name: String?
    public let username: String?
    public let email: String?
    public let address: Address?

    public init(id: Int, name: String?, username: String?, email: String?, adddress: Address?) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = adddress
    }
}

public struct Address: Codable {
    public let street: String?
    public let suite: String?
    public let city: String?
    public let zipcode: String?
    public let geo: Geo?
    
    public init(street: String?, suite: String?, city: String?, zipcode: String?, geo: Geo?) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}

public struct Geo: Codable {
    public let lat: String?
    public let lng: String?
    
    public init(lat: String?, lng: String?) {
        self.lat = lat
        self.lng = lng
    }
}

