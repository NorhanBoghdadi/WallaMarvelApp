//
//  MockMarvelRepository.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 09/02/2025.
//

@testable import WallaMarvel

final class MockMarvelRepository: MarvelRepositoryProtocol {
    var shouldFail = false
    var error: Error?
    var characters: [CharacterDataModel] = []
    var character: CharacterDataModel?

    func getCharacters(page: Int) async throws -> [CharacterDataModel] {
        if shouldFail {
            throw error ?? NetworkError.invalidResponse
        }
        return characters
    }

    func getCharacterDetails(id: Int) async throws -> CharacterDataModel {
        if shouldFail {
            throw error ?? NetworkError.invalidResponse
        }
        guard let character = character else {
            throw NetworkError.noData
        }
        return character
    }
}
