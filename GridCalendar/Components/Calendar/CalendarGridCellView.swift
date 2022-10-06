//
//  CalendarGridCellView.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/07.
//

import SwiftUI

struct CalendarGridCellView: View {
    var text: String
    var textColor: Color = .black
    var didTap: (() -> Void) = {}
    
    var body: some View {        
        return Button(action: didTap) {
            Text(text)
                .foregroundColor(textColor)
        }
    }
}

struct CalendarGridCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarGridCellView(text: "1")
                .frame(width: 50, height: 50)
            CalendarGridCellView(text: "1", textColor: .red)
            CalendarGridCellView(text: "1", textColor: .red, didTap: { print("hello") })
        }
    }
}
