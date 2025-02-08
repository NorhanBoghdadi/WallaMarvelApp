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
            await presenter?.searchHeroes(query: searchText)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            Task {
                await presenter?.searchHeroes(query: text)
            }
        }
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        Task {
            await presenter?.searchHeroes(query: "")
        }
        searchBar.resignFirstResponder()
    }
}
extension ListHeroesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.bounds.height

        if position > contentHeight - screenHeight * 1.5 {
            Task {
                await presenter?.loadMoreHeroes()
            }
        }
    }
}
