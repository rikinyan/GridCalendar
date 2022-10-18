//
//  Calendar+.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/18.
//

import Foundation

extension Calendar {
    enum Weekday: Int {
        case Sun = 1
        case Mon
        case Tus
        case Wed
        case Thu
        case Fri
        case Sat
        case none
    }
    
    func monthDayCount(year: Int, month: Int) -> Int? {
        var nextMonthDate = DateComponents(calendar: self, year: year, month: month + 1, day: 1)
        // 0にすることで、求めたい月の最終日になる。
        nextMonthDate.day = 0
        
        guard let date = date(from: nextMonthDate) else { return nil }
        return component(.day, from: date)
    }
    
    func weekday(date: Date) -> Weekday {
        Weekday.init(rawValue: self.component(.weekday, from: date)) ?? .none
    }
    
    func calendarRows(year: Int, month: Int) -> [[(dayCount: Int, weekday: Weekday)]] {
        var dateListSeparatedByTheWeek: [[(Int, Weekday)]] = []
        
        guard let dayCount = monthDayCount(year: year, month: month) else {
            return []
        }
        
        var insertedWeekList: [(Int, Weekday)] = []
        (1...dayCount).forEach { dayNumber in
            let date = self.date(from: DateComponents(
                calendar: self,
                year: year,
                month: month,
                day: dayNumber
            )) ?? Date()
            let weekday = self.weekday(date: date)
            
            insertedWeekList.append((dayNumber, weekday))
            
            // 土曜日で区切る。
            if weekday == .Sat {
                dateListSeparatedByTheWeek.append(insertedWeekList)
                insertedWeekList = []
            }
        }
        
        if !insertedWeekList.isEmpty {
            dateListSeparatedByTheWeek.append(insertedWeekList)
        }
        
        return dateListSeparatedByTheWeek
    }
}

