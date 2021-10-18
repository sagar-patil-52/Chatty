//
//  LocalStorageHandler.swift
//  Chatty
//
//  Created by mmt on 18/10/21.
//


import Foundation
import CoreData

class LocalStorageHandler  {
        
    func storeMessage( message : Message) {
        
        let entityName = Constants.CoreDataStrings.msgEntity
        var entity = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                         into: PersistenceService.context) as! StoredMessage
        
        entity.chatbotName = message.chatBotName
        entity.chatbotID = Int64(message.chatBotID)
        entity.message = message.message
        entity.emoticon = message.emotion
        if let side = message.side {
            entity.side = Int16(side)
        } else {
            entity.side = 2
        }
        
        
        saveData()
        
    }
    
    func fetchMessages() -> [Message]? {
        var messages = [Message]()

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataStrings.msgEntity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try PersistenceService.context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let msg = data as? StoredMessage {
                    
                    print("message : \(msg)")
                    let id = Int(msg.chatbotID)
                    let side = Int(msg.side)
                    let name = msg.chatbotName ?? ""
                    let message = msg.message ?? ""
                    let emoticon = msg.emoticon ?? ""
                    
                    let chatMsg = Message.init(chatBotName: name, chatBotID: id, message: message, emotion: emoticon, side: side)
                    messages.append(chatMsg)
                    
                }
            }
        } catch {
            print(Constants.Error.dataFetchError)
        }
        return messages
    }
    
    
    
    func saveData() {
        PersistenceService.saveContext()
    }
}

