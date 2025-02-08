import Foundation

protocol MarvelRepositoryProtocol {
    func getCharacters(page: Int) async throws -> [CharacterDataModel]
    func getCharacterDetails(id: Int) async throws -> CharacterDataModel
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func getCharacters(page: Int) async throws -> [CharacterDataModel] {
        let response: CharacterDataContainer = try await networkService.request(
            endpoint: .characters(page: page)
        )
        return response.characters
    }

    func getCharacterDetails(id: Int) async throws -> CharacterDataModel {
        let response: CharacterDataContainer = try await networkService.request(
            endpoint: .characterDetail(id: id)
        )
        guard let character = response.characters.first else {
            throw NetworkError.noData
        }
        return character
    }
}
