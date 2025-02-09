//
//  MockListHeroesUI.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 09/02/2025.
//

@testable import WallaMarvel

final class MockListHeroesUI: ListHeroesUI {
    var updatedHeroes: [CharacterDataModel]?
    var didShowInitialLoading = false
    var didHideInitialLoading = false
    var didShowPaginationLoading = false
    var didHidePaginationLoading = false

    func update(heroes: [CharacterDataModel]) {
        updatedHeroes = heroes
    }

    func showInitialLoading() {
        didShowInitialLoading = true
    }

    func hideInitialLoading() {
        didHideInitialLoading = true
    }

    func showPaginationLoading() {
        didShowPaginationLoading = true
    }

    func hidePaginationLoading() {
        didHidePaginationLoading = true
    }
}
