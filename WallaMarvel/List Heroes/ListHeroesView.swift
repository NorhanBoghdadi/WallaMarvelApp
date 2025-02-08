import Foundation
import UIKit

final class ListHeroesView: UIView {
    enum Layout {
        static let padding: CGFloat = 16
        static let spacing: CGFloat = 12
    }

    lazy var initialLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()

    lazy var paginationLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search heroes..."
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .black
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.showsCancelButton = true
        return searchBar
    }()

    lazy var heroesTableView: UITableView = {
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

        [searchBar, heroesTableView,
         initialLoadingIndicator, paginationLoadingIndicator].forEach {
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
            heroesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            initialLoadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            initialLoadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            paginationLoadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            paginationLoadingIndicator.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
