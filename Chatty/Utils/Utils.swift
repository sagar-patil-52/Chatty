//
//  Utils.swift
//  Chatty
//
//  Created by mmt on 17/10/21.
//

import Foundation


final class Utils {
    
    static func getTime(date: Date) -> String {
        
        let hour = Calendar.current.component(.hour, from: date)
        let mins = Calendar.current.component(.minute, from: date)
        let time = String(format: "%02d:%02d", hour, mins)
        return time
    }
    
    static func formatDate(date: Date) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "E, d MMM yyyy"
        return dateformat.string(from: date)
    }
}
