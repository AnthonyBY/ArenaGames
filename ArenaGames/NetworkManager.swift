//
//  NetworkManager.swift
//  ArenaGames
//
//  Created by Anton Marchanka on 12/1/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func post(endpoint: String, parameters: [String: Any]) async throws -> Data {
        var request = URLRequest(url: URL(string: "https://stage.arena.plan9.tech\(endpoint)")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }

    func get(endpoint: String, queryParams: [String: String]) async throws -> Data {
        var urlComponents = URLComponents(string: "https://stage.arena.plan9.tech\(endpoint)")!
        urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        let (data, _) = try await URLSession.shared.data(from: urlComponents.url!)
        return data
    }
}
