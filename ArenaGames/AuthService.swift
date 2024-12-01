//
//  AuthService.swift
//  ArenaGames
//
//  Created by Anton Marchanka on 11/30/24.
//

import Foundation

struct AuthResponse: Codable {
    struct TokenDetails: Codable {
        let token: String
        let expiresIn: Int
    }

    let accessToken: TokenDetails
    let refreshToken: TokenDetails
}

class AuthService {
    private let baseURL = "https://stage.arena.plan9.tech/api"
    private var authToken: String?

    // Sign-in function
    func signIn(login: String, password: String) async throws -> AuthResponse {
        guard let url = URL(string: "\(baseURL)/v1/auth/sign-in") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["login": login, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        // Log the raw data (optional for debugging)
        print("Raw Response: \(String(data: data, encoding: .utf8) ?? "No Data")")

        // Check HTTP response status
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }

        // Parse the JSON response into the AuthResponse model
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        authToken = authResponse.accessToken.token
        return authResponse
    }

    // Fetch balance by currency
    func fetchBalanceByCurrency() async throws -> [String: Double] {
        guard let authToken = authToken else {
            throw URLError(.userAuthenticationRequired)
        }
        guard let url = URL(string: "\(baseURL)/v1/user/balance") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(authToken)", forHTTPHeaderField: "access-token")

        let (data, response) = try await URLSession.shared.data(for: request)

        // Check HTTP response status
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        // Parse the JSON response into a dictionary
        let decodedData = try JSONDecoder().decode([String: Double].self, from: data)
        return decodedData
    }
}
