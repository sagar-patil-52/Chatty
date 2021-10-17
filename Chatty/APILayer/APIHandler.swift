//
//  APIHandler.swift
//  Chatty
//
//  Created by mmt on 17/10/21.
//

import Foundation

class APIHandler {
    
    //TODO:Inject Dependency, Use Co-ordinator pattern
    var networkManager = NetworkHandler()
    
    //APIs
    func getStoredMessages() -> [Message]? {
        //TODO : Retrieve messages from local storage
        return nil
    }
    
    func sendMessage(message: String, completionHandler : @escaping CompletionHandler) {
        
        do {
            let url = try getFinalUrl(message:message)
            networkManager.getDataForAPI(url: url) { (data, error) -> (Void) in
                do {
                    let userlist = try JSONDecoder().decode(User.self, from: data as! Data)
                    completionHandler(userlist, nil)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Sagar : Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Sagar : Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Sagar : Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch  {
                    print("error : \(error)")
                    completionHandler(nil, ChatError.Failure(message: error.localizedDescription))
                }
            }
        } catch  {
            completionHandler(nil, error as? ChatError)
        }
    }
}

extension APIHandler {
    
    func getFinalUrl(message: String) throws -> URL  {
        
        guard let baseURL = URL(string: Constants.URLList.baseURL) else {
            throw ChatError.Failure(message: "Failed creating an URL")
        }
        var urlComponents : URLComponents?
        
        let chatUrl = baseURL.appendingPathComponent(Constants.URLList.chatAPI)
        urlComponents = URLComponents(url: chatUrl, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: Constants.APIParams.apiKey, value: "6nt5d1nJHkqbkphe"),
            URLQueryItem(name: Constants.APIParams.message, value: message),
            URLQueryItem(name: Constants.APIParams.chatBotID, value: "63906"),
            URLQueryItem(name: Constants.APIParams.externalID, value: "Sagar")
        ]
        
        guard let finalURL = urlComponents?.url else {
            throw ChatError.Failure(message: "Network Error")
        }
        return finalURL
    }
}
