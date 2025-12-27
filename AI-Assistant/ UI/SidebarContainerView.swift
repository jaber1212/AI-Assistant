    //
    //  SidebarContainerView.swift
    //  AI-Assistant
    //
    //  Created by M.jaber on 25/12/2025.
    //

    import Foundation
    import UIKit
    final class SidebarContainerView: UIView {

        let iconsView = SidebarIconsView()
        let contentView = SidebarView()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            setupLayout()
        }

        required init?(coder: NSCoder) { fatalError() }

        private func setupUI() {
            let bg = UIColor.black

            backgroundColor =  Colors.borderGray
            layer.cornerRadius = 24
            clipsToBounds = true

            iconsView.backgroundColor = bg
            contentView.backgroundColor = bg

            iconsView.layer.borderWidth = 0
            contentView.layer.borderWidth = 0

            iconsView.layer.shadowOpacity = 0
            contentView.layer.shadowOpacity = 0

            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale

            addSubview(iconsView)
            addSubview(contentView)
        }

        private func setupLayout() {
            iconsView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                // Icons strip
                iconsView.leadingAnchor.constraint(equalTo: leadingAnchor),
                iconsView.topAnchor.constraint(equalTo: topAnchor),
                iconsView.bottomAnchor.constraint(equalTo: bottomAnchor),
                iconsView.widthAnchor.constraint(equalToConstant: 72),

                // Sidebar content
                contentView.leadingAnchor.constraint(equalTo: iconsView.trailingAnchor,constant: 0.3),
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
    }
