//
//  MarvelRepositoryTests.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 09/02/2025.
//

import Testing
@testable import WallaMarvel

@Suite("Marvel Repository Tests")
struct MarvelRepositoryTests {
    struct TestData {
        var sut: MarvelRepository!
        var mockNetworkService: MockNetworkService!
    }

    init() async throws {
        self.data = TestData()
        data.mockNetworkService = MockNetworkService()
        data.sut = MarvelRepository(networkService: data.mockNetworkService)
    }

    @Test("Successfully fetches characters")
    func testGetCharactersSuccess() async throws {
        // Given
        let expectedHeroes = [CharacterDataModel.mock()]
        let container = CharacterDataContainer(
            count: 0,
            limit: 20,
            offset: 1,
            characters: expectedHeroes
        )
        data.mockNetworkService.result = container

        // When
        let result = try await data.sut.getCharacters(page: 0)

        // Then
        #expect(result.count == expectedHeroes.count)
        #expect(result.first?.name == expectedHeroes.first?.name)
    }

    @Test("Handles character fetch failure")
    func testGetCharactersFailure() async throws {
        // Given
        data.mockNetworkService.shouldFail = true
        data.mockNetworkService.error = NetworkError.invalidResponse

        // When/Then
        await #expect {
            _ = try await data.sut.getCharacters(page: 0)
        } throws: { error in
            guard let networkError = error as? NetworkError else {
                return false
            }
            return networkError == NetworkError.invalidResponse
        }
    }

    private var data: TestData
}
