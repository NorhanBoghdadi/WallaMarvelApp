//
//  APIEndpoint.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 06/02/2025.
//

import Foundation

// MARK: - Endpoint Protocol
protocol APIEndpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

enum MarvelEndpoint: APIEndpoint {
    case characters

    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        }
    }

    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()

        switch self {
        default:
            break
        }
        return items
    }
}
