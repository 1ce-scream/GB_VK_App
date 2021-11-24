//
//  SaveGroupDataOperation.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 24.11.2021.
//

import Foundation
import RealmSwift

 final class SaveGroupDataOperation: AsyncOperation {
//     var realmGroup: Results<Community>?
//
//     init(realmGroup: Results<Community>?) {
//         self.realmGroup = realmGroup
//         super.init()
//     }

     override func main() {
         guard
             !isCancelled,
             let parseOperation = dependencies.first as? ParseGroupDataOperation,
             let responceData = parseOperation.outputData
         else {
             state = .finished
             return
         }

         OperationQueue.main.addOperation {
             do {
                 let groupData = responceData.response.items

                 try RealmService.save(items: groupData)
                 self.state = .finished
             } catch {
                 print("Ошибка сохранения в Realm", error)
             }
         }
     }
 }

class SavingDataOperation<T: Object & Codable>: Operation {
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
            let outputData = parseDataOperation.outputData else { return }
        
       do {
            let realm = try Realm()
        let oldValues = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldValues)
            realm.add(outputData)
            try realm.commitWrite()
            print("Completed Saving")
        } catch {
            print(error)
        }
    }
}

