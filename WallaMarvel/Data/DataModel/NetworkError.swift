//
//  NetworkError.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 06/02/2025.
//


// MARK: - Network Error
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    case noData
}
