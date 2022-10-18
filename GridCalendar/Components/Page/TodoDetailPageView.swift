//
//  TodoDetailPageView.swift
//  GridCalendar
//
//  Created by 力石優武 on 2022/10/18.
//

import SwiftUI

struct TodoDetailPageView: View {
    let item: TodoItem?
    
    var body: some View {
        VStack {
            Text("title").font(.subheadline)
            Text(item?.title ?? "").font(.title)
            Divider()
            Text("span").font(.subheadline)
            Text("\(DateFormatter.todoStartDateFormatter.string(from: item?.startDatetime ?? Date())) ~ \(DateFormatter.todoEndDateFormatter.string(from: item?.endDatetime ?? Date()))")
            Divider()
            Text("description").font(.subheadline)
            Text(item?.description ?? "")
                .frame(alignment: .leading)
        }
    }
}

struct TodoDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailPageView(item: TodoItem.sampleTodoItem)
    }
}

