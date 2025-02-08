import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes() async
    func searchHeroes(query: String) async
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getCharactersRepo: MarvelRepositoryProtocol
    private var allHeroes: [CharacterDataModel] = []

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
            self.allHeroes = characters
            self.ui?.update(heroes: characters)
        } catch {
            print(error.localizedDescription)
        }
    }

    func searchHeroes(query: String) async {
        if query.isEmpty {
            self.ui?.update(heroes: allHeroes)
        } else {
            let filtered = allHeroes.filter { $0.name.lowercased().contains(query.lowercased()) }
            self.ui?.update(heroes: filtered)
        }
    }
}

