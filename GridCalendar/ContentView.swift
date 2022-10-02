//
//  ContentView.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CalendarGridView(year: 2022, month: 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
