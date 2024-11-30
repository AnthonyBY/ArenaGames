//
//  Models.swift
//  ArenaGames
//
//  Created by Anton Marchanka on 11/30/24.
//

import Foundation

struct UserRequest: Codable {
    let email: String
    let user: User
    let referralCode: String
    let isSubscribeNewsletter: Bool
    let lastName: String
    let firstName: String
    let photoHash: String
}

struct User: Codable {
    let name: String
    let password: String
}
