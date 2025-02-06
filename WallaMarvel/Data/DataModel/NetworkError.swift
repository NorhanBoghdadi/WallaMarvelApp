//
//  NetworkError.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 06/02/2025.
//


// MARK: - Network Error
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Error)
}
