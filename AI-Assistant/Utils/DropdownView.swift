//
//  DropdownView.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit
final class DropdownView: UIControl {

    private let titleLabel = UILabel()
    private let arrow = UIImageView(image: UIImage(systemName: "chevron.down"))
    private(set) var selectedValue: String?


    private var items: [String] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTap()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = UIColor(white: 0.15, alpha: 1)
        layer.cornerRadius = 10

        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .lightGray
        titleLabel.isUserInteractionEnabled = false   // ✅ مهم

        arrow.tintColor = .lightGray
        arrow.isUserInteractionEnabled = false        // ✅ مهم

        let spacer = UIView()
        spacer.isUserInteractionEnabled = false       // ✅ مهم

        let stack = UIStackView(arrangedSubviews: [titleLabel, spacer, arrow])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false         // 🔥 الأهم

        addSubview(stack)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupTap() {
        addTarget(self, action: #selector(showMenu), for: .touchUpInside)
    }

    func setItems(_ items: [String]) {
        self.items = items
        selectedValue = items.first   // ✅ مهم
        titleLabel.text = items.first
    }


  
    
    
    @objc private func showMenu() {
        guard let vc = findViewController() else { return }

        let popover = DropdownPopoverVC()
        popover.items = items
        popover.selected = selectedValue   // 👈 هنا تُستخدم

        popover.onSelect = { [weak self] value in
            guard let self else { return }
            self.selectedValue = value     // ✅ مهم
            self.titleLabel.text = value
            self.sendActions(for: .valueChanged)
        }



        popover.modalPresentationStyle = .popover
        popover.preferredContentSize = CGSize(width: 260, height: min(44 * items.count + 12, 260))

        if let p = popover.popoverPresentationController {
            p.sourceView = self
            p.sourceRect = bounds
            p.permittedArrowDirections = .up
            p.backgroundColor = UIColor(white: 0.12, alpha: 1)
        }

        vc.present(popover, animated: true)
    }

}
