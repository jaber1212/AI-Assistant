//
//  LightsControlView.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit
final class LightsControlView: SidebarItemView {
    private var observerID: UUID?
    private let colorsContainer = UIView()
    private let colorsStack = UIStackView()
    private let slider = UISlider()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure(
            title: "Board Room",
            subtitle: "Lights",
            statusText: "100% - Green"
        )

        setupExtras()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupExtras() {

        // Container (بدون border)
        colorsContainer.backgroundColor = .clear
        colorsContainer.layer.cornerRadius = 12
        colorsContainer.translatesAutoresizingMaskIntoConstraints = false

        // Stack
        colorsStack.axis = .horizontal
        colorsStack.spacing = 30
        colorsStack.translatesAutoresizingMaskIntoConstraints = false

        let colors: [UIColor] = [
            .systemYellow,
            .systemRed,
            .systemBlue,
            .systemGreen
        ]

        colors.forEach { color in
            let dot = UIView()
            dot.backgroundColor = color
            dot.layer.cornerRadius = 9
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.isUserInteractionEnabled = true

            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: 18),
                dot.heightAnchor.constraint(equalToConstant: 18)
            ])

            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(colorTapped(_:))
            )
            dot.addGestureRecognizer(tap)

            colorsStack.addArrangedSubview(dot)
        }


        colorsContainer.addSubview(colorsStack)

        NSLayoutConstraint.activate([
            colorsStack.centerXAnchor.constraint(equalTo: colorsContainer.centerXAnchor),
            colorsStack.centerYAnchor.constraint(equalTo: colorsContainer.centerYAnchor),
            colorsContainer.heightAnchor.constraint(equalToConstant: 36)
        ])

        // Slider
        slider.value = 1
        slider.minimumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = UIColor(white: 0.35, alpha: 1)
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)

        // ترتيب مطابق للصورة
        contentStack.addArrangedSubview(colorsContainer)
     
        
        contentStack.addArrangedSubview(slider)
    }
    
    @objc private func colorTapped(_ gesture: UITapGestureRecognizer) {
        guard let color = gesture.view?.backgroundColor else { return }

        DeviceStateManager.shared.update(
            .lights,
            color: color
        )
    }

    @objc private func sliderChanged() {
        let level = Int(slider.value * 100)

        DeviceStateManager.shared.update(
            .lights,
            level: level
        )
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bind()
    }
    private func bind() {
        observerID = DeviceStateManager.shared.addObserver { [weak self] type, state in
            guard type == .lights else { return }
            self?.apply(state)
        }
    }

    private func apply(_ state: DeviceState) {
        // ON / OFF
        alpha = state.isOn ? 1 : 0.5
        isUserInteractionEnabled = state.isOn

        // Slider
        slider.value = Float(state.level) / 100

        // Color
        let colorName = state.color == .systemBlue ? "Blue"
            : state.color == .systemRed ? "Red"
            : state.color == .systemYellow ? "Yellow"
            : "Green"

        configure(
            title: "Board Room",
            subtitle: "Lights",
            statusText: "\(state.level)% - \(colorName)"
        )

        backgroundColor = state.isOn
            ? state.color?.withAlphaComponent(0.15)
            : UIColor.darkGray.withAlphaComponent(0.3)
    }
    deinit {
        if let id = observerID {
            DeviceStateManager.shared.removeObserver(id)
        }
    }

}
