//
//  ChatViewModel.swift
//  Chatty
//
//  Created by mmt on 16/10/21.
//

import Foundation

protocol ChatDelegate : AnyObject {
    func didReceiveMessage()
}

class ChatViewModel {
    
    var messages = [Message]()
    weak var chatDelegate : ChatDelegate?
    
    func fetchAllMessages() {
        let msgs =  LocalStorageHandler().fetchMessages()
        if msgs?.count ?? 0 > 0 {
            messages.append(contentsOf: msgs!)
        }
    }
    
    func sendMessage(message: String) {
        
        let msg = Message.init(chatBotName: "Sagar", chatBotID: 52, message: message, emotion: "", side: 1)
        LocalStorageHandler().storeMessage(message: msg)
        messages.append(msg)
        let apiHandler = APIHandler()
        apiHandler.sendMessage(message:message, completionHandler: { [weak self] (data, error) -> (Void) in
                if let data = data as? User {
                    
                    let chat = data.message
                    let msg = Message.init(chatBotName: chat.chatBotName, chatBotID: chat.chatBotID, message: chat.message, emotion: chat.emotion, side: 2)
                    LocalStorageHandler().storeMessage(message: msg)
                    self?.messages.append(msg)
                    self?.chatDelegate?.didReceiveMessage()
            }
        })
    }
}
