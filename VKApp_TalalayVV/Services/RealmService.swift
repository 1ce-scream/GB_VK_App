//
//  RealmService.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 17.10.2021.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let deleteIfMigration = Realm.Configuration(
        deleteRealmIfMigrationNeeded: true)
    
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
        print(realm.configuration.fileURL ?? "")
        return realm.objects(T.self)
    }
    
    static func delete<T:Object>(object: Results<T>) throws {
        let realm = try Realm()
        try realm.write{
            realm.delete(object)
        }
    }
}
