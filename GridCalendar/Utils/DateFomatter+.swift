//
//  DateFomatter+.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/18.
//

import Foundation
    
    
extension DateFormatter {
    static var todoStartDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
        formatter.locale = Locale(identifier: "ja-JP")
        return formatter
    }
    
    static var todoEndDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        formatter.locale = Locale(identifier: "ja-JP")
        return formatter
    }
}
