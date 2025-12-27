//
//  SourceItemCell.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit



final class SourceItemCell: UICollectionViewCell {

    // MARK: - Views
    private let imageView = UIImageView()
    private let titlePill = UIView()
    private let titleLabel = UILabel()
    private let toggle = UISwitch()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Configure
    func configure(with source: Source) {
        imageView.image = source.image
        titleLabel.text = source.name
        toggle.isOn = source.isActive
    }

    // MARK: - Setup
    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 16
        backgroundColor = .clear

        // Image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        // Title pill
        titlePill.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        titlePill.layer.cornerRadius = 12
        titlePill.translatesAutoresizingMaskIntoConstraints = false

        // Title text
        titleLabel.font = Fonts.caption
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Toggle
        toggle.onTintColor = Colors.activeGreen
        toggle.backgroundColor = .white
        toggle.layer.cornerRadius = toggle.bounds.height / 2
        toggle.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)
        contentView.addSubview(titlePill)
        contentView.addSubview(toggle)
        titlePill.addSubview(titleLabel)

        NSLayoutConstraint.activate([

            // Image fills card
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            // Title pill (top-left)
            titlePill.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titlePill.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            titleLabel.leadingAnchor.constraint(equalTo: titlePill.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: titlePill.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: titlePill.topAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: titlePill.bottomAnchor, constant: -6),

            // Toggle (top-right)
            toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            toggle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }
}
