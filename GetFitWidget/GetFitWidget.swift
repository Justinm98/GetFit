//
//  GetFitWidget.swift
//  GetFitWidget
//
//  Created by CS3714 on 12/4/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), photo: "ImageUnavailable")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), photo: "ImageUnavailable")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let photos = ["ImageUnavailable", "ImageUnavailable", "ImageUnavailable", "ImageUnavailable", "ImageUnavailable"]

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for minuteOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, photo: photos[minuteOffset])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let photo: String
}

struct GetFitWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
            Image(entry.photo)
                .resizable()
        
    }
}

@main
struct GetFitWidget: Widget {
    let kind: String = "GetFitWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GetFitWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct GetFitWidget_Previews: PreviewProvider {
    static var previews: some View {
        GetFitWidgetEntryView(entry: SimpleEntry(date: Date(), photo: "ImageUnavailable"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
