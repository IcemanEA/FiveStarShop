//
//  StorageManager.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 20.08.2022.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private let defaults = UserDefaults.standard
    private let userIDKey = "userID"
    
    private init() { }
    
    func save(userID: UUID) {
        defaults.set(userID.uuidString, forKey: userIDKey)
    }
    
    func fetchUserID() -> UUID? {
        let id = defaults.string(forKey: userIDKey) ?? ""
        
        return UUID(uuidString: id)
    }
    
    func deleteUserID() {
        defaults.removeObject(forKey: userIDKey)
    }
}
