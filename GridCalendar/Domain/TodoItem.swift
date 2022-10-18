//
//  TodoItem.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/18.
//

import Foundation

struct TodoItem {
    let title: String
    let startDatetime: Date
    let endDatetime: Date
    let description: String
    
    static var sampleTodoItem: TodoItem? {
        var dateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            year: 2020,
            month: 1,
            day: 1,
            hour: 12,
            minute: 0
        )
        
        guard let startDate = dateComponents.date else { return nil }
        
        dateComponents.minute = 30
        guard let endDate = dateComponents.date else { return nil }
        
        return TodoItem(title: "Study SwiftUi", startDatetime: startDate, endDatetime: endDate, description: "study swiftui")
    }
}
