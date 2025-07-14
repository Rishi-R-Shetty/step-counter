//
//  stepcounterwidgetLiveActivity.swift
//  stepcounterwidget
//
//  Created by Ravindra Sankappa Shetty on 14/07/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct stepcounterwidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct stepcounterwidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: stepcounterwidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension stepcounterwidgetAttributes {
    fileprivate static var preview: stepcounterwidgetAttributes {
        stepcounterwidgetAttributes(name: "World")
    }
}

extension stepcounterwidgetAttributes.ContentState {
    fileprivate static var smiley: stepcounterwidgetAttributes.ContentState {
        stepcounterwidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: stepcounterwidgetAttributes.ContentState {
         stepcounterwidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: stepcounterwidgetAttributes.preview) {
   stepcounterwidgetLiveActivity()
} contentStates: {
    stepcounterwidgetAttributes.ContentState.smiley
    stepcounterwidgetAttributes.ContentState.starEyes
}
