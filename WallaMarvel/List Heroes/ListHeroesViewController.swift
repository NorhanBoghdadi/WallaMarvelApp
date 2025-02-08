import UIKit

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?
    
    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.ui = self
        title = presenter?.screenTitle()
        setupTableView()
        setupSearchBar()
        loadData()
    }
    private func setupTableView() {
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        mainView.heroesTableView.delegate = self
    }
    private func setupSearchBar() {
        mainView.searchBar.delegate = self
        navigationController?.navigationBar.barStyle = .black
        title = presenter?.screenTitle()
    }

    private func loadData() {
        Task {
            await presenter?.getHeroes()
        }
    }
}

extension ListHeroesViewController: ListHeroesUI {
    func update(heroes: [CharacterDataModel]) {
        listHeroesProvider?.heroes = heroes
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let hero = listHeroesProvider?.heroes[indexPath.row] else { return }

        let presenter = HeroDetailPresenter(heroId: hero.id)
        let detailViewController = HeroDetailViewController(hero: hero, presenter: presenter)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
extension ListHeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Task {
            
        }
    }
}
