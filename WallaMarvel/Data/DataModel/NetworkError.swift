//
//  NetworkError.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 06/02/2025.
//


// MARK: - Network Error
enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    case noData

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse),
             (.decodingError, .decodingError),
             (.noData, .noData):
            return true
        case (.serverError(let lhsMsg), .serverError(let rhsMsg)):
            return lhsMsg == rhsMsg
        default:
            return false
        }
    }
}
