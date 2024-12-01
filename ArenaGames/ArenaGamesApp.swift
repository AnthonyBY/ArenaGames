//
//  ArenaGamesApp.swift
//  ArenaGames
//
//  Created by Anton Marchanka on 11/30/24.
//

import SwiftUI

@main
struct ArenaGamesApp: App {
    @AppStorage("sharedData", store: UserDefaults(suiteName: "Anton-Marchanka.ArenaGames")) var sharedData: String = "Default Value"
    var body: some Scene {
        WindowGroup {
            ArenaListView()
        }
    }
}
