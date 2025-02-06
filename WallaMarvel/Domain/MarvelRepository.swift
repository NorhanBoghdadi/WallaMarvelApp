import Foundation

protocol MarvelRepositoryProtocol {
    func getCharacters() async throws -> [CharacterDataModel]
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func getCharacters() async throws -> [CharacterDataModel] {
        let response: CharacterDataContainer = try await networkService.request(
            endpoint: .characters
        )
        return response.characters
    }
}
