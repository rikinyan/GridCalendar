//
//  ContentView.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            CalendarGridView(year: 2022, month: 1, parentWidth: geometry.size.width)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                .frame(width:geometry.size.width)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
