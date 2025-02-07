//
//  HeroDetailPresenter.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//


protocol HeroDetailPresenterProtocol {
    func getHeroDetails(id: Int) async
}

final class HeroDetailPresenter: HeroDetailPresenterProtocol {
    private let marvelRepository: MarvelRepositoryProtocol
    
    init(heroId: Int, marvelRepository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.marvelRepository = marvelRepository
    }
    
    func getHeroDetails(id: Int) async {
        do {
            let details = try await marvelRepository.getCharacterDetails(id: id)
            // TODO: Update UI with details
        } catch {
            print("Error fetching hero details: \(error)")
        }
    }
}
