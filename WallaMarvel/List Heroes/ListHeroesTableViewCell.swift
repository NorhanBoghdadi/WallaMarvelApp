import Foundation
import UIKit
import Kingfisher

final class ListHeroesTableViewCell: UITableViewCell {
    private enum Layout {
        static let padding: CGFloat = 16
        static let imageHeight: CGFloat = 170
        static let cornerRadius: CGFloat = 12
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        view.layer.cornerRadius = Layout.cornerRadius
        view.clipsToBounds = true
        return view
    }()

    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var overlayView: UIView = {
        let view = UIView()
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        gradient.locations = [0.4, 1.0]
        view.layer.addSublayer(gradient)
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        [containerView, heroImageView, overlayView, nameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        contentView.addSubview(containerView)
        containerView.addSubview(heroImageView)
        containerView.addSubview(overlayView)
        containerView.addSubview(nameLabel)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.padding/2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.padding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.padding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.padding/2),

            heroImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            overlayView.topAnchor.constraint(equalTo: containerView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Layout.padding),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Layout.padding),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Layout.padding)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        overlayView.layer.sublayers?.first?.frame = overlayView.bounds
    }

    func configure(model: CharacterDataModel) {
        nameLabel.text = model.name
        if let url = URL(string: model.thumbnail.path + "/landscape_incredible." + model.thumbnail.extension) {
            heroImageView.kf.setImage(with: url)
        }
    }
}
