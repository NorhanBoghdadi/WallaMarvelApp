import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes() async
    func loadMoreHeroes() async
    func searchHeroes(query: String) async
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [CharacterDataModel])
    func showInitialLoading()
    func hideInitialLoading()
    func showPaginationLoading()
    func hidePaginationLoading()
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    private var currentPage = 0
    private var isLoading = false
    private var hasMorePages = true

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
        guard !isLoading else { return }
        isLoading = true
        ui?.showInitialLoading()
        do {
            let characters = try await getCharactersRepo.getCharacters(page: 0)
            currentPage = 0
            allHeroes = characters
            hasMorePages = !characters.isEmpty
            self.ui?.update(heroes: characters)
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
        ui?.hideInitialLoading()
    }
    
    func loadMoreHeroes() async {
        guard !isLoading, hasMorePages else { return }
        isLoading = true
        ui?.showPaginationLoading()

        do {
            let nextPage = currentPage + 1
            let characters = try await getCharactersRepo.getCharacters(page: nextPage)

            if !characters.isEmpty {
                currentPage = nextPage
                allHeroes.append(contentsOf: characters)
                ui?.update(heroes: allHeroes)
            } else {
                hasMorePages = false
            }
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
        ui?.hidePaginationLoading()
    }

    func searchHeroes(query: String) async {
        if query.isEmpty {
            ui?.update(heroes: allHeroes)
        } else {
            let filtered = allHeroes.filter { $0.name.lowercased().contains(query.lowercased()) }
            ui?.update(heroes: filtered)
        }
    }
}

