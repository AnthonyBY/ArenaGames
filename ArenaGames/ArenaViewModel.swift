//
//  ArenaViewModel.swift
//  ArenaGames
//
//  Created by Anton Marchanka on 11/29/24.
//

import Foundation

enum State {
    case login
    case loggedIn
}

struct CoinModel: Codable {
    let name: String
    let blockchain: String
    let image: String
    var balance: Double
    let currency: String
}

class ArenaViewModel: ObservableObject {
    @Published var state: State = .login
   // var coinsList
    @Published var coins: [CoinModel] = availableCoins

    init() {

    }
}

let availableCoins = [
    CoinModel(name: "USDT", blockchain: "PLYGON", image: "usdt", balance: 0, currency: "USDT"),
    CoinModel(name: "POL", blockchain: "POLYGON", image: "polygon", balance: 0, currency: "POL"),
    CoinModel(name: "Gorilla", blockchain: "Skale", image: "gorilla", balance: 2100, currency: "GT"),
    CoinModel(name: "Manta", blockchain: "Manta", image: "manta", balance: 0, currency: "manta"),
    CoinModel(name: "LineaETH", blockchain: "LINEA", image: "lineaETH", balance: 0, currency: "eth"),
]

