//
//  RealmService.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 17.10.2021.
//

import Foundation
import RealmSwift
import UIKit

class RealmService {
    private var networkService = NetworkService()
    static let deleteIfMigration = Realm.Configuration(
        deleteRealmIfMigrationNeeded: true)
    
    func updateFriends(){
    
        networkService.getFriends(onComplete: { (friends) in
            do {
                let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                let realm = try Realm(configuration: config)
                let oldValues = realm.objects(Friend.self)
                realm.beginWrite()
                realm.delete(oldValues)
                realm.add(friends)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        })
    }
    
    static func save<T:Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy = .modified) throws {
            
            let realm = try Realm(configuration: configuration)
            print(configuration.fileURL ?? "")
            try realm.write {
                realm.add(
                    items, update: update)
            }
        }
    
    static func load<T:Object>(typeOf: T.Type) throws -> Results<T> {
        let realm = try Realm()
        return realm.objects(T.self)
    }
    
    static func load<T:Object>(object: Results<T>) throws {
        let realm = try Realm()
        try realm.write{
            realm.delete(object)
        }
    }
}
