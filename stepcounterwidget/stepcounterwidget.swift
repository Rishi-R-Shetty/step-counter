//
//  stepcounterwidget.swift
//  stepcounterwidget
//
//  Created by Ravindra Sankappa Shetty on 14/07/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct stepcounterwidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading,spacing:0) {
            Text("4,790").font(.system(size: 30,weight: .bold).monospaced())
            Text("Steps").font(.system(size: 20).monospaced()).foregroundStyle(.secondary)
        Spacer()
        
        HStack {
            Image(systemName:"shoe")
            Text("176 days!")
            
        }.padding(.bottom,5)
            VStack(spacing:3){
                HStack(spacing:3){
                    ForEach(1...5, id: \.self) { _ in
                        Rectangle().frame(height:5)
                    }
                }
                HStack(spacing:3){
                    ForEach(1...5, id: \.self) { _ in
                        Rectangle().frame(height:5)
                    }
                }
                .foregroundStyle(.secondary)
            }
        }
        .foregroundStyle(.green)
    }
}

struct stepcounterwidget: Widget {
    let kind: String = "stepcounterwidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            stepcounterwidgetEntryView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    stepcounterwidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
