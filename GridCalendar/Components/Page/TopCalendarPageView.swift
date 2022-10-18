//
//  TopCalendarPageView.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/18.
//

import SwiftUI

struct TopCalendarPageView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    CalendarGridView(year: 2022, month: 1)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        .frame(width:geometry.size.width)
                    List {
                        CalendarLineTodoView()
                        CalendarLineTodoView()
                        CalendarLineTodoView()
                    }
                }
            }
        }
    }
}

struct TopCalendarPageView_Previews: PreviewProvider {
    static var previews: some View {
        TopCalendarPageView()
    }
}
