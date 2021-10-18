//
//  StoredMessage+CoreDataProperties.swift
//  Chatty
//
//  Created by mmt on 18/10/21.
//
//

import Foundation
import CoreData


extension StoredMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredMessage> {
        return NSFetchRequest<StoredMessage>(entityName: "StoredMessage")
    }

    @NSManaged public var chatbotID: Int64
    @NSManaged public var chatbotName: String?
    @NSManaged public var emoticon: String?
    @NSManaged public var message: String?
    @NSManaged public var side: Int16

}

extension StoredMessage : Identifiable {

}
