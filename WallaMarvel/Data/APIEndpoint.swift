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
    case characters(page: Int)
    case characterDetail(id: Int)

    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .characterDetail(let id):
            return "/v1/public/characters/\(id)"
        }
    }

    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        switch self {
        case .characters:
            items.append(URLQueryItem(name: "limit", value: "20"))
            items.append(URLQueryItem(name: "offset", value: "\(offset)"))
        default:
            break
        }
        return items
    }

    private var offset: Int {
        switch self {
        case .characters(let page):
            return page * 20
        default:
            return 0
        }
    }
}
