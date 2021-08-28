//
//  Date+Extension.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 28/08/21.
//

import Foundation

extension Date {
    
    static func getDateString(_ date: String) -> String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        let firstDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: firstDate!)
    }
    
}
