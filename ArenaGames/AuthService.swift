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
    static let shared = AuthService()
    private let baseURL = "https://stage.arena.plan9.tech/api"

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
        return authResponse
    }
}
