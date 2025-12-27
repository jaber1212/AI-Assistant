//
//  SidebarView.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit
final class SidebarView: UIView {

    private let stackView = UIStackView()

    private let lightsView = LightsControlView()
    private let audioView = AudioControlView()
    private let microphoneView = MicrophoneControlView()
    private let privacyGlassView = PrivacyGlassControlView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
//       backgroundColor = .black
//    layer.cornerRadius = 12
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
//        backgroundColor = UIColor(white: 0.06, alpha: 1) // أغمق شوي
        clipsToBounds = true
        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.alignment = .fill

        addSubview(stackView)

        [
            lightsView,
            audioView,
            microphoneView,
            privacyGlassView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
    }

    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
}

