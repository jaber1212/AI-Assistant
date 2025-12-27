//
//  MainViewController.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Views
    private var sidebarWidthConstraint: NSLayoutConstraint!
    private var sidebarLeadingConstraint: NSLayoutConstraint!
    private var scenesLeadingConstraint: NSLayoutConstraint!
    private var scenesTrailingConstraint: NSLayoutConstraint!

    private let sidebarContainerView = SidebarContainerView() // ✅ الجديد
    private let scenesBarView = ScenesBarView()
    private let videoWallView = VideoWallView()
    private let sourcesListView = SourcesListView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        sidebarContainerView.iconsView.bind()
        applyLayoutMode()


    }
    private enum LayoutMode {
        case regular   // iPad
        case compact   // iPhone
    }

    private var layoutMode: LayoutMode {
        traitCollection.horizontalSizeClass == .compact ? .compact : .regular
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyLayoutMode(animated: true)
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = Colors.appBackground

        view.addSubview(sidebarContainerView)
        view.addSubview(scenesBarView)
        view.addSubview(videoWallView)
        view.addSubview(sourcesListView)
    }

  
    private func setupLayout() {

        sidebarContainerView.translatesAutoresizingMaskIntoConstraints = false
        scenesBarView.translatesAutoresizingMaskIntoConstraints = false
        videoWallView.translatesAutoresizingMaskIntoConstraints = false
        sourcesListView.translatesAutoresizingMaskIntoConstraints = false

        let sidebarFullWidth: CGFloat = 72 + LayoutConstants.sidebarWidth - 50

        // Sidebar constraints (stored)
        sidebarLeadingConstraint = sidebarContainerView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 4
        )

        sidebarWidthConstraint = sidebarContainerView.widthAnchor.constraint(
            equalToConstant: sidebarFullWidth
        )

        // Scenes constraints (stored)
        scenesLeadingConstraint = scenesBarView.leadingAnchor.constraint(
            equalTo: sidebarContainerView.trailingAnchor,
            constant: 24
        )

        scenesTrailingConstraint = scenesBarView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -24
        )

        NSLayoutConstraint.activate([

            // Sidebar
            sidebarLeadingConstraint,
            sidebarWidthConstraint,
            sidebarContainerView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 4
            ),
            sidebarContainerView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -4
            ),

            // Scenes bar
            scenesLeadingConstraint,
            scenesTrailingConstraint,
            scenesBarView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            scenesBarView.heightAnchor.constraint(
                equalToConstant: LayoutConstants.scenesBarHeight
            ),

            // Video wall
            videoWallView.leadingAnchor.constraint(
                equalTo: scenesBarView.leadingAnchor
            ),
            videoWallView.trailingAnchor.constraint(
                equalTo: scenesBarView.trailingAnchor
            ),
            videoWallView.topAnchor.constraint(
                equalTo: scenesBarView.bottomAnchor,
                constant: 16
            ),
            videoWallView.bottomAnchor.constraint(
                equalTo: sourcesListView.topAnchor,
                constant: -16
            ),

            // Sources row
            sourcesListView.leadingAnchor.constraint(
                equalTo: scenesBarView.leadingAnchor
            ),
            sourcesListView.trailingAnchor.constraint(
                equalTo: scenesBarView.trailingAnchor
            ),
            sourcesListView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            sourcesListView.heightAnchor.constraint(
                equalToConstant: LayoutConstants.sourcesRowHeight
            )
        ])
    }
    private func applyLayoutMode(animated: Bool = false) {

        let changes = {
            switch self.layoutMode {

            case .regular:
                self.sidebarWidthConstraint.constant =
                    72 + LayoutConstants.sidebarWidth - 50
                self.sidebarLeadingConstraint.constant = 4
                self.sidebarContainerView.alpha = 1
                self.sidebarContainerView.isUserInteractionEnabled = true

            case .compact:
                self.sidebarWidthConstraint.constant = 0
                self.sidebarLeadingConstraint.constant = -300
                self.sidebarContainerView.alpha = 0
                self.sidebarContainerView.isUserInteractionEnabled = false

            }

            self.view.layoutIfNeeded()
        }

        animated
            ? UIView.animate(withDuration: 0.3, animations: changes)
            : changes()
    }

}
