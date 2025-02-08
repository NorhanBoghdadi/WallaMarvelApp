import Foundation
import UIKit

final class ListHeroesView: UIView {
    enum Layout {
        static let padding: CGFloat = 16
        static let spacing: CGFloat = 12
    }

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search heroes..."
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .black
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        return searchBar
    }()

    let heroesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ListHeroesTableViewCell.self, forCellReuseIdentifier: "ListHeroesTableViewCell")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: Layout.padding, left: 0, bottom: Layout.padding, right: 0)
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .black

        [searchBar, heroesTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),

            heroesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            heroesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
