//
//  Followers.swift
//  GitFinda
//
//  Created by Shivang on 29/12/25.
//

import Foundation

nonisolated struct Follower: Codable, Hashable, Sendable{
    let login: String
    let avatarUrl: String
}
