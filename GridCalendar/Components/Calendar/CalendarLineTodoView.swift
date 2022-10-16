//
//  CalendarLineTodo.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/17.
//

import SwiftUI

struct CalendarLineTodoView: View {
    let startDateFormatter = DateFormatter()
    let endDateFormatter = DateFormatter()
    let todoTitle = "hello world!"
    let startDatetime = Date()
    let endDatetime = Date()
    
    init() {
        startDateFormatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
        startDateFormatter.locale = Locale(identifier: "ja-JP")
        endDateFormatter.dateFormat = "hh:mm:ss"
        endDateFormatter.locale = Locale(identifier: "ja-JP")
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.cyan)
            .frame(height: 100)
            .overlay {
                VStack(spacing: 5) {
                    Text("hello world")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    Divider()
                        .overlay(.white)
                    Text("\(startDateFormatter.string(from: Date())) -  \(endDateFormatter.string(from: Date()))")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                }
            }
            
    }
}

struct CalendarLineTodo_Previews: PreviewProvider {
    static var previews: some View {
        CalendarLineTodoView()
    }
}
