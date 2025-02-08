import Foundation
import UIKit

final class ListHeroesView: UIView {
    enum Layout {
        static let padding: CGFloat = 16
        static let spacing: CGFloat = 12
    }

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
        addSubview(heroesTableView)
        heroesTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heroesTableView.topAnchor.constraint(equalTo: topAnchor),
            heroesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
