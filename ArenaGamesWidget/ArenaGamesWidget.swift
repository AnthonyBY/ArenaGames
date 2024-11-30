//
//  ArenaGamesWidget.swift
//  ArenaGamesWidget
//
//  Created by Anton Marchanka on 11/30/24.
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
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct ArenaGamesWidgetEntryView : View {
    var entry: Provider.Entry
    var coins: [CoinModel] = availableCoins
    var body: some View {
        VStack {
            Text("Arena Games")
                .fontWeight(.medium)
                .padding(.top, 8)
            ForEach(coins, id:\.name) { coin in
                HStack {
                    Image(coin.image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(4)
                    VStack(alignment: .leading) {
                        Text(coin.name)
                            .fontWeight(.medium)
                        Text(coin.blockchain)
                            .fontWeight(.light)

                    }
                    Spacer()
                    Text("\(Int(coin.balance))")
                        .fontWeight(.light)
                    Text(coin.currency.uppercased())
                        .fontWeight(.light)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
      
    }
     //   .background(.blue)
}

struct ArenaGamesWidget: Widget {
    let kind: String = "ArenaGamesWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ArenaGamesWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
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

#Preview(as: .systemExtraLarge) {
    ArenaGamesWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}

