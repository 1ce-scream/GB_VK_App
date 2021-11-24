//
//  SaveGroupDataOperation.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 24.11.2021.
//

import Foundation
import RealmSwift

 final class SaveGroupDataOperation: AsyncOperation {

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
