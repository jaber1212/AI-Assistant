//
//  DeviceStateManager.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit
final class DeviceStateManager {

    static let shared = DeviceStateManager()

    private(set) var states: [DeviceType: DeviceState] = [
        .lights: .init(isOn: true, level: 100, color: .systemGreen),
        .audio: .init(isOn: true, level: 100, color: nil, selection: "No Active Window"),
        .microphone: .init(isOn: true, level: 0, color: nil),
        .privacyGlass: .init(isOn: false, level: 0, color: nil, selection: "Meeting")

    ]

    // ✅ multiple observers
    private var observers: [UUID: (DeviceType, DeviceState) -> Void] = [:]

    @discardableResult
    func addObserver(
        _ observer: @escaping (DeviceType, DeviceState) -> Void
    ) -> UUID {
        let id = UUID()
        observers[id] = observer
        return id
    }

    func removeObserver(_ id: UUID) {
        observers.removeValue(forKey: id)
    }
    func updateSelection(
        _ type: DeviceType,
        selection: String
    ) {
        guard var state = states[type] else { return }

        state.selection = selection
        states[type] = state

        observers.values.forEach {
            $0(type, state)
        }
    }


    func update(
        _ type: DeviceType,
        isOn: Bool? = nil,
        level: Int? = nil,
        color: UIColor? = nil
    ) {
        guard var state = states[type] else { return }

        if let isOn = isOn { state.isOn = isOn }
        if let level = level { state.level = level }
        if let color = color { state.color = color }

        states[type] = state

        observers.values.forEach {
            $0(type, state)
        }
    }
}
