import UIKit
import UIKit

final class SidebarIconsView: UIView {

    
    private let headerView = UIView()
    private let appIconImageView = UIImageView()
    private let stackView = UIStackView()
    private var observerID: UUID?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = UIColor(white: 0.06, alpha: 1) // أغمق شوي

        setupHeader()
        bind()
        setupStack()
    }

    func bind() {
        observerID = DeviceStateManager.shared.addObserver { [weak self] type, state in
            guard let self else { return }

            for case let button as SidebarIconButton in self.stackView.arrangedSubviews {
                if button.deviceType == type {
                    button.setState(state.isOn)
                }
            }
        }
    }


    // MARK: - Header (App Icon)
    private func setupHeader() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            headerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerView.widthAnchor.constraint(equalToConstant: 64),
            headerView.heightAnchor.constraint(equalToConstant: 64)
        ])

        appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        appIconImageView.contentMode = .scaleAspectFit

        appIconImageView.image = UIImage(named: "logo")
        appIconImageView.layer.cornerRadius = 12
        appIconImageView.clipsToBounds = true
        headerView.addSubview(appIconImageView)

        NSLayoutConstraint.activate([
            appIconImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            appIconImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            appIconImageView.widthAnchor.constraint(equalToConstant: 60),
            appIconImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    // MARK: - Buttons Stack
    private func setupStack() {
        stackView.axis = .vertical
        stackView.spacing = 60          // ✅ نفس التصميم
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 80), // 🔥 المسافة الصحيحة
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        stackView.addArrangedSubview(
            SidebarIconButton(
                icon: UIImage(systemName: "lightbulb.fill"),
                isOn: true,
                deviceType: .lights
            )
        )

        stackView.addArrangedSubview(
            SidebarIconButton(
                icon: UIImage(systemName: "speaker.wave.2.fill"),
                isOn: true,
                deviceType: .audio
            )
        )

        stackView.addArrangedSubview(
            SidebarIconButton(
                icon: UIImage(systemName: "mic.fill"),
                isOn: true,
                deviceType: .microphone
            )
        )

        stackView.addArrangedSubview(
            SidebarIconButton(
                icon: UIImage(systemName: "eye.slash.fill"),
                isOn: false,
                deviceType: .privacyGlass
            )
        )

    }
}
