//
//  HeroDetailView.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//

import UIKit

final class HeroDetailView: UIView {
    private enum Layout {
        static let padding: CGFloat = 20
        static let spacing: CGFloat = 16
        static let imageHeight: CGFloat = 400
    }

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    private let heroImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        label.numberOfLines = 0
        label.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }()

    private let comicsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        stack.layer.cornerRadius = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stack
    }()

    private let seriesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        stack.layer.cornerRadius = 12
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stack
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

        [scrollView, contentStackView, heroImageContainer, heroImageView, overlayView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        contentStackView.axis = .vertical
        contentStackView.spacing = Layout.spacing

        setupImageContainer()
        setupStackViews()
        setupConstraints()
    }

    private func setupImageContainer() {
        heroImageContainer.addSubview(heroImageView)
        heroImageContainer.addSubview(overlayView)
        heroImageContainer.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: heroImageContainer.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: heroImageContainer.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: heroImageContainer.trailingAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: heroImageContainer.bottomAnchor),

            overlayView.topAnchor.constraint(equalTo: heroImageContainer.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: heroImageContainer.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: heroImageContainer.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: heroImageContainer.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: heroImageContainer.leadingAnchor, constant: Layout.padding),
            titleLabel.trailingAnchor.constraint(equalTo: heroImageContainer.trailingAnchor, constant: -Layout.padding),
            titleLabel.bottomAnchor.constraint(equalTo: heroImageContainer.bottomAnchor, constant: -Layout.padding)
        ])
    }

    private func setupStackViews() {
        [heroImageContainer, createSectionView("Description", descriptionLabel),
         createSectionView("Comics", comicsStackView),
         createSectionView("Series", seriesStackView)].forEach {
            contentStackView.addArrangedSubview($0)
        }
    }

    private func createSectionView(_ title: String, _ contentView: UIView) -> UIView {
        let container = UIView()
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white

        [titleLabel, contentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Layout.padding),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Layout.padding),

            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Layout.padding),
            contentView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Layout.padding),
            contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        return container
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            heroImageContainer.heightAnchor.constraint(equalToConstant: Layout.imageHeight)
        ])
    }

    func configure(with hero: CharacterDataModel) {
        titleLabel.text = hero.name
        descriptionLabel.text = hero.description.isEmpty ? "No description available" : hero.description

        if let url = URL(string: hero.thumbnail.path + "/landscape_incredible." + hero.thumbnail.extension) {
            heroImageView.kf.setImage(with: url)
        }

        configureComics(hero.comics)
        configureSeries(hero.series)
    }

    private func configureComics(_ comics: ComicList) {
        comicsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        comics.items.forEach { comic in
            let label = createItemLabel(comic.name)
            comicsStackView.addArrangedSubview(label)
        }
    }

    private func configureSeries(_ series: SeriesList) {
        seriesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        series.items.forEach { series in
            let label = createItemLabel(series.name)
            seriesStackView.addArrangedSubview(label)
        }
    }

    private func createItemLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }
}
