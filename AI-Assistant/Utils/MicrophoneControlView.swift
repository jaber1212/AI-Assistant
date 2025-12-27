//
//  MicrophoneControlView.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit
final class MicrophoneControlView: SidebarItemView {

    private var observerID: UUID?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(
            title: "Board Room",
            subtitle: "Microphone",
            statusText: "ON"
        )
    }

    required init?(coder: NSCoder) { fatalError() }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bind()
    }

    private func bind() {
        observerID = DeviceStateManager.shared.addObserver { [weak self] type, state in
            guard type == .microphone else { return }
            self?.apply(state)
        }
    }

    private func apply(_ state: DeviceState) {
        alpha = state.isOn ? 1 : 0.5

        configure(
            title: "Board Room",
            subtitle: "Microphone",
            statusText: state.isOn ? "ON" : "OFF"
        )
    }

    deinit {
        if let id = observerID {
            DeviceStateManager.shared.removeObserver(id)
        }
    }
}
