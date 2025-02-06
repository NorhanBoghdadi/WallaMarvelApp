//
//  NetworkServiceProtocol.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 06/02/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: MarvelEndpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(endpoint: MarvelEndpoint) async throws -> T {
        guard var components = URLComponents(string: APIConfiguration.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        var queryItems = endpoint.queryItems
        queryItems.append(contentsOf: APIConfiguration.authenticationQueryItems())
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.serverError("Status code: \(httpResponse.statusCode)")
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
