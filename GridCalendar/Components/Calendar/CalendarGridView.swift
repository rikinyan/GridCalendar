//
//  CalendarGrid.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/02.
//

import SwiftUI

// CalendarのidentifierはEnvironmentObjectにしたいね。

extension Calendar {
    func monthDayCount(year: Int, month: Int) -> Int? {
        var nextMonthDate = DateComponents(calendar: self, year: year, month: month + 1, day: 1)
        // 0にすることで、求めたい月の最終日になる。
        nextMonthDate.day = 0
        
        guard let date = date(from: nextMonthDate) else { return nil }
        return component(.day, from: date)
    }
}

struct CalendarGridView: View {
    let year: Int
    let month: Int
    
    private let dayCount: Int
    private let calendar = Calendar(identifier: .japanese)
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        
        dayCount = calendar.monthDayCount(year: year, month: month) ?? 0
    }
    
    @available(iOS 16.0, *)
    var calendarRows: [[String]] {
        var dateListSeparatedByTheWeek: [[String]] = []
        
        var insertedWeekList: [String] = []
        (1...dayCount).forEach { dayNumber in
            let text = "\(dayNumber)"
            insertedWeekList.append(text)
            
            // 土曜日であることを確認
            let date = calendar.date(from: DateComponents(
                year: year,
                month: month,
                day: dayNumber
            )) ?? Date()
            
            if Calendar(identifier: .japanese).component(.weekday, from: date) == 6 {
                dateListSeparatedByTheWeek.append(insertedWeekList)
                insertedWeekList = []
            }
        }
        
        if !insertedWeekList.isEmpty {
            dateListSeparatedByTheWeek.append(insertedWeekList)
        }
        
        return dateListSeparatedByTheWeek
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            return Grid(verticalSpacing: 10) {
                GridRow {
                    Text("日")
                        .foregroundColor(.red)
                    Text("月")
                    Text("火")
                    Text("水")
                    Text("木")
                    Text("金")
                    Text("土")
                        .foregroundColor(.blue)
                }
                ForEach(calendarRows, id: \.self) { weekList in
                    GridRow {
                        if leadingEmptyCell(weekList: weekList) {
                            let firstRowEmptyCount: Int = 7 - weekList.count
                            ForEach(1 ... firstRowEmptyCount, id: \.self) { _ in
                                Color.clear
                                    .gridCellUnsizedAxes([.horizontal, .vertical])
                            }
                        }
                        
                        ForEach(weekList, id: \.self) { dayNumber in
                            Text(dayNumber)
                        }
                    }
                }
            }
        } else {
            return Text("this calendar is available on a device having iOS 16.0 or newer.")
        }
    }
    
    func leadingEmptyCell(weekList: [String]) -> Bool {
        weekList[0] == "1" && weekList.count < 7
    }
}

struct CalendarGridView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarGridView(year: 2022, month: 1)
    }
}
