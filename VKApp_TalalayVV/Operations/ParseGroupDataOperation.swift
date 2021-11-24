//
//  ParseGroupDataOperation.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 24.11.2021.
//

import Foundation

final class ParseGroupDataOperation: AsyncOperation {
     var outputData: Response<Community>?

     override func main() {
         guard
             !isCancelled,
             let getDataOperation = dependencies.first as? GetGroupDataOperation,
             let data = getDataOperation.data
         else {
             state = .finished
             return
         }

         do {
             outputData = try JSONDecoder()
                 .decode(Response<Community>.self, from: data)
             state = .finished
         } catch {
             print("Ошибка декодера JSON", error.localizedDescription)
         }
     }
 }
