//
//  LocalStorageHandler.swift
//  Chatty
//
//  Created by mmt on 18/10/21.
//


import Foundation
import CoreData

class LocalStorageHandler  {
        
    func storeMessage<T>( entity : T) {
        
//        let entityName = Constants.Strings.message
//        NSEntityDescription.insertNewObject(forEntityName: entityName,
//                                                            into: PersistenceService.context)
    }
    
    func fetchMessages() -> [Message]? {
        var users = [Message]()
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Strings.message)
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try PersistenceService.context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                if let user = data as? User {
//                    users.append(user)
//                }
//            }
//        } catch {
//            print(Constants.Error.dataFetchError)
//        }
        return users
    }
    
    
    
    func saveData() {
        PersistenceService.saveContext()
    }
}

