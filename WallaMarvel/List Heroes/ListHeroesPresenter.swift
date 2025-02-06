import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes() async
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getCharactersRepo: MarvelRepositoryProtocol

    init(getCharactersRepo: MarvelRepositoryProtocol = MarvelRepository()) {
        self.getCharactersRepo = getCharactersRepo
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() async {
        do {
            let characters = try await getCharactersRepo.getCharacters()
            print("Characters \(characters)")
            self.ui?.update(heroes: characters)
        } catch {
            print(error.localizedDescription)
        }
    }
}

