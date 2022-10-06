//
//  CalendarGrid.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/02.
//

import SwiftUI

// CalendarのidentifierはEnvironmentObjectにしたいね。

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
}

struct CalendarGridView: View {
    let year: Int
    let month: Int
    
    private let dayCount: Int
    private let calendar = Calendar(identifier: .gregorian)
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        
        dayCount = calendar.monthDayCount(year: year, month: month) ?? 0
    }
    
    @available(iOS 16.0, *)
    var calendarRows: [[(dayCount: Int, weekday: Calendar.Weekday)]] {
        var dateListSeparatedByTheWeek: [[(Int, Calendar.Weekday)]] = []
        
        var insertedWeekList: [(Int, Calendar.Weekday)] = []
        (1...dayCount).forEach { dayNumber in
            // 土曜日であることを確認
            let date = calendar.date(from: DateComponents(
                calendar: calendar,
                year: 2022,
                month: month,
                day: dayNumber
            )) ?? Date()
            let weekday = calendar.weekday(date: date)
            
            insertedWeekList.append((dayNumber, weekday))
            
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
                ForEach(calendarRows, id: \[(Int, Calendar.Weekday)][0].0) { weekList in
                    GridRow {
                        if leadingEmptyCell(weekList: weekList) {
                            let firstRowEmptyCount: Int = 7 - weekList.count
                            ForEach(1 ... firstRowEmptyCount, id: \.self) { _ in
                                Color.clear
                                    .gridCellUnsizedAxes([.horizontal, .vertical])
                            }
                        }
                        
                        ForEach(weekdayNumberGridRowCells(weekList: weekList), id: \.text) { cell in
                            cell
                        }
                    }
                }
            }
        } else {
            return Text("this calendar is available on a device having iOS 16.0 or newer.")
        }
    }
    
    func leadingEmptyCell(weekList: [(Int, Calendar.Weekday)]) -> Bool {
        weekList[0].0 == 1 && weekList.count < 7
    }
    
    func weekdayNumberGridRowCells(weekList: [(Int, Calendar.Weekday)]) -> [CalendarGridCellView] {
        weekList.compactMap { dayNumber, weekday in
            var textColor = Color.black
            if weekday == .Sun {
                textColor = .red
            } else if weekday == .Sat {
                textColor = .blue
            }
            
            return CalendarGridCellView(text: String(dayNumber), textColor: textColor, didTap: {})
        }
    }
}

struct CalendarGridView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarGridView(year: 2022, month: 1)
    }
}
