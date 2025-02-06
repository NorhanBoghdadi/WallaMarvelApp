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
    var queryItems: [URLQueryItem]? { get }
}
