import UIKit
class SidebarItemView: UIView {

    // MARK: - UI

    private let cardView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let statusLabel = UILabel()

    let contentStack = UIStackView() // 👈 خارج الكارد

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setupBaseUI() {
        translatesAutoresizingMaskIntoConstraints = false

        // Card
        cardView.layer.cornerRadius = 16
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.white.cgColor
        cardView.backgroundColor = .black
        cardView.translatesAutoresizingMaskIntoConstraints = false

        // Labels
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = .lightGray

        subtitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        subtitleLabel.textColor = .white

        statusLabel.font = .systemFont(ofSize: 14)
        statusLabel.textColor = .gray

        let labelsStack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            statusLabel
        ])
        labelsStack.axis = .vertical
        labelsStack.spacing = 6
        labelsStack.translatesAutoresizingMaskIntoConstraints = false

        cardView.addSubview(labelsStack)
        addSubview(cardView)

        // Content Stack (outside card)
        contentStack.axis = .vertical
        contentStack.spacing = 14
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentStack)

        NSLayoutConstraint.activate([
            // Card
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),

            labelsStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            labelsStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            labelsStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            labelsStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),

            // Content
            contentStack.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 10),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }

    // MARK: - Configure

    func configure(title: String, subtitle: String, statusText: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        statusLabel.text = statusText
    }
}
