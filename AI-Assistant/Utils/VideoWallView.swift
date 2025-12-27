//
//  VideoWallView.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit


final class VideoWallView: UIView {

    // MARK: - Views
    private let headerBar = UIView()
    private let titleLabel = UILabel()
    private let powerButton = UIButton(type: .system)

    private let iconView = UIImageView()
    private let hintLabel = UILabel()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - UI
    private func setupUI() {

        // Main panel
        backgroundColor = .black
        layer.cornerRadius = 22
        layer.borderWidth = 1
        layer.borderColor =  Colors.borderGray.cgColor
        layer.masksToBounds = true

        // Header bar (SINGLE BAR)
        headerBar.backgroundColor = Colors.videoWallHeader
        headerBar.layer.cornerRadius = 20

        // Title
        titleLabel.text = "Video Wall"
        titleLabel.font = Fonts.title
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        // Power button (inside same bar)
        powerButton.setImage(UIImage(systemName: "power"), for: .normal)
        powerButton.tintColor = Colors.activeGreen

        // Center icon
        iconView.image = UIImage(systemName: "display")
        iconView.tintColor = UIColor.white.withAlphaComponent(0.35)
        iconView.contentMode = .scaleAspectFit

        // Hint text
        hintLabel.text = "Drag the source here to view it on this screen"
        hintLabel.font = Fonts.subtitle
        hintLabel.textColor = UIColor.white.withAlphaComponent(0.35)
        hintLabel.textAlignment = .center

        addSubview(headerBar)
        headerBar.addSubview(titleLabel)
        headerBar.addSubview(powerButton)

        addSubview(iconView)
        addSubview(hintLabel)
    }

    // MARK: - Layout
    private func setupLayout() {

        [headerBar, titleLabel, powerButton, iconView, hintLabel]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([

            // Header bar
            headerBar.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            headerBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerBar.heightAnchor.constraint(equalToConstant: 40),
            headerBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),

            // Title centered in bar
            titleLabel.centerXAnchor.constraint(equalTo: headerBar.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerBar.centerYAnchor),

            // Power button INSIDE bar
            powerButton.centerYAnchor.constraint(equalTo: headerBar.centerYAnchor),
            powerButton.trailingAnchor.constraint(equalTo: headerBar.trailingAnchor, constant: -14),
            powerButton.widthAnchor.constraint(equalToConstant: 24),
            powerButton.heightAnchor.constraint(equalToConstant: 24),

            // Center icon
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -6),
            iconView.widthAnchor.constraint(equalToConstant: 70),
            iconView.heightAnchor.constraint(equalToConstant: 70),

            // Hint
            hintLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 14),
            hintLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
