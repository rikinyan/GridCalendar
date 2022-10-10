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

struct CalendarGridView: View {
    let year: Int
    let month: Int
    let cellWidth = floor(300 / 7)
    let cellHeight = 30.0
    
    private let calendar = Calendar(identifier: .gregorian)
        
    var body: some View {
        if #available(iOS 16.0, *) {
            
            return Grid(horizontalSpacing: 0, verticalSpacing: 10) {
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
                .gridCellUnsizedAxes([.vertical, .horizontal])
                .frame(width: cellWidth)
                
                ForEach(calendar.calendarRows(year: year, month: month), id: \[(Int, Calendar.Weekday)][0].0) { weekList in
                    GridRow {
                        if hasLeadingEmptyCell(weekList: weekList) {
                            let firstRowEmptyCount = 7 - weekList.count
                            ForEach(1 ... firstRowEmptyCount, id: \.self) { _ in
                                Color.clear
                                    .gridCellUnsizedAxes([.vertical])
                            }
                        }
                        
                        ForEach(weekdayNumberGridRowCells(weekList: weekList), id: \.text) { cell in
                            cell
                        }
                    }
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                    .frame(width: cellWidth, height: cellHeight)
                }
            }
        } else {
            return Text("this calendar is available on a device having iOS 16.0 or newer.")
        }
    }
    
    func hasLeadingEmptyCell(weekList: [(Int, Calendar.Weekday)]) -> Bool {
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
            .frame(width: 320)
    }
}
