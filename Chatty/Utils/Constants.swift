//
//  Constants.swift
//  Chatty
//
//  Created by mmt on 17/10/21.
//

import Foundation
import UIKit



struct Constants {
    
    struct TableConfig {
        static let rowHeight : CGFloat = 110
    }
    
    struct Colors {
        static let blueColor = UIColor.init(red: 120/255, green:20/255, blue: 80/255, alpha: 1)
        static let darkBlueColor = UIColor.init(red: 175/255, green:45/255, blue: 66/255, alpha: 1)
    }
    
    struct URLList {
        static let baseURL = "https://www.personalityforge.com/"
        static let chatAPI = "api/chat/"
        
    }
    
    struct Strings {
        static let container = "Chatty"
    }
    
    struct CoreDataStrings {
        static let msgEntity = "StoredMessage"
    }
    
    struct HEXColorString {
        static let rightCellBgColor = "E1F7CB"
        static let chatViewBgColor = "E4DDD6"
    }
    
    struct APIParams {
        static let apiKey = "apiKey"
        static let message = "message"
        static let chatBotID = "chatBotID"
        static let externalID = "externalID"
    }
    
    struct Error {
        static let dataFetchError = "Failed to fetch data from url"
        static let errorAlertTitle = "Oops"
    }
    
    struct Identifiers {
        static let main = "Main"
        static let chatVC = "ChatViewController"
        static let leftCell = "LeftTableCell"
        static let rightCell = "RightTableCell"
    }
}
