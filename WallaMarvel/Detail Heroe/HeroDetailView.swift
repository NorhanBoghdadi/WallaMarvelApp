//
//  HeroDetailView.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//

import UIKit

final class HeroDetailView: UIView {
    private enum Layout {
        static let imageHeight: CGFloat = 200
        static let spacing: CGFloat = 16
        static let padding: CGFloat = 20
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comicsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Comics"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(heroImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(comicsLabel)
        contentView.addSubview(comicsCollectionView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: Layout.imageHeight),

            nameLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: Layout.spacing),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.padding),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Layout.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.padding),

            comicsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Layout.spacing * 2),
            comicsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.padding),
            comicsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.padding),

            comicsCollectionView.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: Layout.spacing),
            comicsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.padding),
            comicsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            comicsCollectionView.heightAnchor.constraint(equalToConstant: 180),
            comicsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.padding)
        ])

    }

    func configure(with hero: CharacterDataModel) {
        nameLabel.text = hero.name
        descriptionLabel.text = hero.description.isEmpty ? "No description available" : hero.description
        
        if let url = URL(string: hero.thumbnail.path + "/landscape_incredible." + hero.thumbnail.extension) {
            heroImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.fill"))
        }
    }
}
