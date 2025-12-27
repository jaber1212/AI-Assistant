//
//  AudioControlView.swift.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit
import UIKit

final class AudioControlView: SidebarItemView {

    private let slider = UISlider()
    private let dropdown = DropdownView()
    private var observerID: UUID?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure(
            title: "Board Room",
            subtitle: "Audio",
            statusText: "100%"
        )

        // Slider
        slider.value = 1
        slider.minimumTrackTintColor = .systemBlue
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)

        // Dropdown
        dropdown.setItems([
            "No Active Window",
            "HDMI",
            "Apple TV"
        ])

        dropdown.addTarget(
            self,
            action: #selector(dropdownChanged),
            for: .valueChanged
        )

        contentStack.addArrangedSubview(slider)
        contentStack.addArrangedSubview(dropdown)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bind()
    }

    private func bind() {
        observerID = DeviceStateManager.shared.addObserver { [weak self] type, state in
            guard type == .audio else { return }
            self?.apply(state)
        }
    }

    private func apply(_ state: DeviceState) {
        alpha = state.isOn ? 1 : 0.5
        isUserInteractionEnabled = state.isOn

        slider.value = Float(state.level) / 100

        configure(
            title: "Board Room",
            subtitle: "Audio",
            statusText: "\(state.level)%"
        )
    }

    @objc private func sliderChanged() {
        let level = Int(slider.value * 100)
        DeviceStateManager.shared.update(.audio, level: level)
    }

    @objc private func dropdownChanged() {
        guard let selected = dropdown.selectedValue else { return }

        DeviceStateManager.shared.updateSelection(
            .audio,
            selection: selected
        )
    }


    deinit {
        if let id = observerID {
            DeviceStateManager.shared.removeObserver(id)
        }
    }
}
