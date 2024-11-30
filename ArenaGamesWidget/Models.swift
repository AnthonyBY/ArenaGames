//
//  Models.swift
//  ArenaGamesWidgetExtension
//
//  Created by Anton Marchanka on 11/30/24.
//

import Foundation

struct CoinModel: Codable {
    let name: String
    let blockchain: String
    let image: String
    var balance: Double
    let currency: String
}

let availableCoins = [
    CoinModel(name: "USDT", blockchain: "PLYGON", image: "usdt", balance: 0, currency: "USDT"),
    CoinModel(name: "POL", blockchain: "POLYGON", image: "polygon", balance: 0, currency: "POL")
  //  CoinModel(name: "Gorilla", blockchain: "Skale", image: "gorilla", balance: 2100, currency: "GT"),
   // CoinModel(name: "Manta", blockchain: "Manta", image: "manta", balance: 0, currency: "manta")
   // CoinModel(name: "LineaETH", blockchain: "LINEA", image: "lineaETH", balance: 0, currency: "eth")
]
