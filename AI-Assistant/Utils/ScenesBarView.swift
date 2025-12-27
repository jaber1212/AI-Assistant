//
//  ScenesBarView.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//
import UIKit


final class ScenesBarView: UIView {

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let menuButton = UIButton(type: .system)
    private let micButton = UIButton(type: .system)
    private var observerID: UUID?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = .clear

        // Main bar
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 14
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = Colors.borderGray.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        titleLabel.text = "Scenes"
        titleLabel.font = Fonts.title
        titleLabel.textColor = .white

        subtitleLabel.text = "Save/Recall a Scene"
        subtitleLabel.font = Fonts.caption
        subtitleLabel.textColor = UIColor(white: 0.75, alpha: 1)

        menuButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        menuButton.tintColor = .white

        // Mic button (outline circle)
        micButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        micButton.tintColor = .systemGreen
        micButton.backgroundColor = .clear
        micButton.layer.cornerRadius = 22
        micButton.layer.borderWidth = 2
        micButton.layer.borderColor = UIColor.systemGreen.cgColor
        menuButton.addTarget(self, action: #selector(showScenesDropdown), for: .touchUpInside)

        [titleLabel, subtitleLabel, menuButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }

        micButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(micButton)
    }
    @objc private func showScenesDropdown() {
        guard let vc = findViewController() else { return }

        let popover = DropdownPopoverVC()
        popover.items = [
            "Meeting",
            "Presentation",
            "Night Mode"
        ]

        // 👇 نقرأ من DeviceStateManager
        popover.selected = DeviceStateManager.shared
            .states[.privacyGlass]?
            .selection

        popover.onSelect = { value in
            DeviceStateManager.shared.updateSelection(
                .privacyGlass,
                selection: value
            )
        }

        popover.modalPresentationStyle = .popover
        popover.preferredContentSize = CGSize(
            width: 220,
            height: min(44 * popover.items.count + 12, 220)
        )

        if let p = popover.popoverPresentationController {
            p.sourceView = menuButton
            p.sourceRect = menuButton.bounds
            p.permittedArrowDirections = .up
            p.backgroundColor = UIColor(white: 0.12, alpha: 1)
        }

        vc.present(popover, animated: true)
    }

    private var isMicOn: Bool = true {
        didSet { updateMicUI() }
    }
    private func setupLayout() {

        NSLayoutConstraint.activate([

            // Bar (right aligned)
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56), // 🔥 reserve space
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 190),
            containerView.heightAnchor.constraint(equalToConstant: 64),

            // Title
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),

            // Subtitle
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),

            // Menu button
            menuButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
            menuButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            // Mic button (VISIBLE now)
            micButton.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 12),
            micButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            micButton.widthAnchor.constraint(equalToConstant: 44),
            micButton.heightAnchor.constraint(equalToConstant: 44),

            // View height
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            trailingAnchor.constraint(equalTo: micButton.trailingAnchor) // 🔥 critical
            
        ])
        
        micButton.addTarget(self, action: #selector(toggleMic), for: .touchUpInside)

    }
    @objc private func toggleMic() {
        isMicOn.toggle()

        DeviceStateManager.shared.update(
            .microphone,
            isOn: isMicOn
        )
    }
    private func updateMicUI() {
        let color: UIColor = isMicOn ? .systemGreen : .systemRed

        micButton.tintColor = color
        micButton.layer.borderColor = color.cgColor
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bind()
    }
    private func bind() {
        observerID = DeviceStateManager.shared.addObserver { [weak self] type, state in
            guard type == .privacyGlass else { return }   // نفس type المستخدم
            self?.subtitleLabel.text = state.selection ?? "Save/Recall a Scene"
        }
    }

    deinit {
        if let id = observerID {
            DeviceStateManager.shared.removeObserver(id)
        }
    }

}
