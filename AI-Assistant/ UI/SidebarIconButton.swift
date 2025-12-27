import UIKit

final class SidebarIconButton: UIControl {

    private let iconView = UIImageView()
     let deviceType: DeviceType
    private(set) var isOn: Bool = false {
        didSet { updateState() }
    }

    init(icon: UIImage?, isOn: Bool, deviceType: DeviceType) {
        self.deviceType = deviceType
        self.isOn = isOn
        super.init(frame: .zero)
        setupUI(icon: icon)
        updateState()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI(icon: UIImage?) {
        translatesAutoresizingMaskIntoConstraints = false

        // ✅ Size & shape (exact)
        layer.cornerRadius = 30
        layer.borderWidth = 2.5
        backgroundColor = .clear

        iconView.image = icon
        iconView.tintColor = .white
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(iconView)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 60),
            heightAnchor.constraint(equalToConstant: 60),

            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22)
        ])

        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }

    private func updateState() {
        layer.borderColor = isOn
            ? UIColor.systemGreen.cgColor
            : UIColor.systemRed.cgColor
    }

    @objc private func toggle() {
        isOn.toggle()

        DeviceStateManager.shared.update(
            deviceType,
            isOn: isOn
        )
    }
    func setState(_ isOn: Bool) {
        self.isOn = isOn
    }

}
