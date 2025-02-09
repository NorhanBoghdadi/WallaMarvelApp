//
//  MockNetworkService.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 09/02/2025.
//

@testable import WallaMarvel

final class MockNetworkService: NetworkServiceProtocol {
    var shouldFail = false
    var error: Error?
    var result: Any?

    func request<T: Decodable>(endpoint: MarvelEndpoint) async throws -> T {
        if shouldFail {
            throw error ?? NetworkError.invalidResponse
        }

        guard let result = result as? T else {
            throw NetworkError.decodingError
        }

        return result
    }
}
