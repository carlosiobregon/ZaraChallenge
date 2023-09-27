//
//  CharacterInfoCollectionViewCell.swift
//  ZaraChallenge
//
//  Created by Carlos Obregon on 25/09/23.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "CharacterInfoCollectionViewCell"

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()

    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()

    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(titleContainerView, valueLabel)
        titleContainerView.addSubviews(titleLabel, iconImageView)
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),

            titleLabel.leftAnchor.constraint(equalTo: iconImageView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),

            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 10),
            iconImageView.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor, constant: 20),

            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = .label
        titleLabel.textColor = .label
    }

    public func configure(with viewModel: CharacterInfoCollectionCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        iconImageView.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
    }
}

