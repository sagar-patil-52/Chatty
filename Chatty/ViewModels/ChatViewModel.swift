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
    
    func sendMessage(message: String) {
        
        let msg = Message.init(chatBotName: "Sagar", chatBotID: 52, message: message, emotion: "", side: 1)
        messages.append(msg)
        let apiHandler = APIHandler()
        apiHandler.sendMessage(message:message, completionHandler: { [weak self] (data, error) -> (Void) in
                if let data = data as? User {
                    self?.messages.append(data.message)
                    self?.chatDelegate?.didReceiveMessage()
            }
        })
    }
}
