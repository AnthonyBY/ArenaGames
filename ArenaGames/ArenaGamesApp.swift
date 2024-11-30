//
//  ArenaGamesApp.swift
//  ArenaGames
//
//  Created by Anton Marchanka on 11/29/24.
//

import SwiftUI

@main
struct ArenaGamesApp: App {
    @StateObject var arenaVieModel = ArenaViewModel()
    var body: some Scene {
        WindowGroup {
            ArenaListView()
                .environmentObject(arenaVieModel)
        }
    }
}
