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

    let customRed = Color(red: 0.9, green: 0.5, blue: 0.5)

    var body: some View {
        VStack {
            Text("Arena Games")
                .fontWeight(.medium)
                .padding(.top, 4)
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
                        .font(.system(size: 14))
                    Text(coin.currency.uppercased())
                        .font(.system(size: 12))

                    Button(action: {
                        // Your action here
                    }) {
                        HStack {
                            Image(systemName: "arrow.up.arrow.down.circle")
                                .font(.system(size: 16))
                            Text("Swap")
                                .fontWeight(.light)
                                .font(.system(size: 18))
                        }
                        .padding(10)
                        .foregroundColor(customRed)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(customRed, lineWidth: 2) // Red border
                        )
                        .background(Color.clear) // Transparent background
                        .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 100, height: 40)
                }
                .padding(.horizontal, 2)
                .padding(.vertical, 0)
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

#Preview(as: .systemLarge) {
    ArenaGamesWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}

