//
//  ListHeroesPresenterTests.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 09/02/2025.
//


import Testing
@testable import WallaMarvel

@Suite("List Heroes Presenter Tests")
struct ListHeroesPresenterTests {
    private var data: TestData

    struct TestData {
        var sut: ListHeroesPresenter!
        var mockRepository: MockMarvelRepository!
        var mockUI: MockListHeroesUI!
    }
    
    init() {
        self.data = TestData()
        data.mockRepository = MockMarvelRepository()
        data.mockUI = MockListHeroesUI()
        data.sut = ListHeroesPresenter(getCharactersRepo: data.mockRepository)
        data.sut.ui = data.mockUI
    }

    @Test("Successfully gets heroes")
    func testGetHeroesSuccess() async throws {
        // Given
        let expectedHeroes = [CharacterDataModel.mock(), CharacterDataModel.mock(id: 2, name: "Iron Man")]
        data.mockRepository.characters = expectedHeroes

        // When
        await data.sut.getHeroes()

        // Then
        #expect(data.mockUI.updatedHeroes?.count == expectedHeroes.count)
        #expect(data.mockUI.didShowInitialLoading)
        #expect(data.mockUI.didHideInitialLoading)
    }

    @Test("Handles get heroes failure")
    func testGetHeroesFailure() async throws {
        // Given
        data.mockRepository.shouldFail = true
        data.mockRepository.error = NetworkError.invalidResponse

        // When
        await data.sut.getHeroes()

        // Then
        #expect(data.mockUI.updatedHeroes == nil)
        #expect(data.mockUI.didShowInitialLoading)
        #expect(data.mockUI.didHideInitialLoading)
    }

    @Test("Successfully loads more heroes")
    func testLoadMoreHeroesSuccess() async throws {
        // Given
        let initialHeroes = [CharacterDataModel.mock()]
        let additionalHeroes = [CharacterDataModel.mock(id: 2, name: "Iron Man")]
        data.mockRepository.characters = initialHeroes

        // When
        await data.sut.getHeroes() // Load initial page
        data.mockRepository.characters = additionalHeroes
        await data.sut.loadMoreHeroes()

        // Then
        #expect(data.mockUI.updatedHeroes?.count == 2)
        #expect(data.mockUI.didShowPaginationLoading)
        #expect(data.mockUI.didHidePaginationLoading)
    }

    @Test("Successfully searches heroes")
    func testSearchHeroes() async throws {
        // Given
        let heroes = [
            CharacterDataModel.mock(name: "Spider-Man"),
            CharacterDataModel.mock(id: 2, name: "Iron Man")
        ]
        data.mockRepository.characters = heroes

        // When
        await data.sut.getHeroes()
        await data.sut.searchHeroes(query: "spider")

        // Then
        #expect(data.mockUI.updatedHeroes?.count == 1)
        #expect(data.mockUI.updatedHeroes?.first?.name == "Spider-Man")
    }
}
