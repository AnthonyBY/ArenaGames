//
//  AuthStore.swift
//  ArenaGames
//
//  Created by Anton Marchanka on 12/1/24.
//


import Foundation

@MainActor
class AuthStore: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var assets: [String: Double] = [:] // Dictionary to store balances by currency

    func login() async throws {
        // Implement your login logic here
        let endpoint = "/login"
        let parameters = ["username": "test", "password": "password"]

        do {
            let response: Data = try await NetworkManager.shared.post(endpoint: endpoint, parameters: parameters)
            // Parse the response if needed
            self.isLoggedIn = true
        } catch {
            self.isLoggedIn = false
            throw error
        }
    }

    func fetchBalanceByCurrency() async throws -> [String: Double] {
        // Fetch balance by currency
        let endpoint = "/user/balance"
        let queryParams = ["currency": "USD"] // Adjust as needed

        do {
            let response: Data = try await NetworkManager.shared.get(endpoint: endpoint, queryParams: queryParams)
            let decodedData = try JSONDecoder().decode([String: Double].self, from: response)
            return decodedData
        } catch {
            throw error
        }
    }

    func updateAssets() async {
        do {
            // Attempt to log in
            try await login()

            // Fetch balance after successful login
            let balance = try await fetchBalanceByCurrency()

            // Update assets on the main actor
            self.assets = balance
            print("Assets updated: \(balance)")
        } catch {
            print("Failed to update assets: \(error.localizedDescription)")
        }
    }
}
