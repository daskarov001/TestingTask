//
//  EncodableExt.swift
//  Networking
//
//  Created by Asqarov Diyorjon on 02/03/25.
//


import Foundation

extension Encodable {
    public func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
    }
}
