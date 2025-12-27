//
//  DropdownPopoverVC.swift
//  AI-Assistant
//
//  Created by M.jaber on 27/12/2025.
//

import Foundation
import UIKit
final class DropdownPopoverVC: UIViewController {
    private let hintLabel: UILabel = {
        let l = UILabel()
        l.text = "Scroll for more"
        l.font = .systemFont(ofSize: 11, weight: .medium)
        l.textColor = UIColor.white.withAlphaComponent(0.4)
        l.textAlignment = .center
        return l
    }()

    var items: [String] = []
    var selected: String?
    var onSelect: ((String) -> Void)?

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.12, alpha: 1)
        view.layer.cornerRadius = 14
        setupTable()
        view.addSubview(hintLabel)
        hintLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hintLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
            hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }

    private func setupTable() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 44
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = true
        tableView.indicatorStyle = .white

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6)
        ])
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyFadeMask()
    }

    private func applyFadeMask() {
        let maskLayer = CAGradientLayer()
        maskLayer.frame = view.bounds

        maskLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor,
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]

        maskLayer.locations = [0, 0.06, 0.94, 1]
        view.layer.mask = maskLayer
    }

}

extension DropdownPopoverVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let value = items[indexPath.row]

        var config = UIListContentConfiguration.valueCell()
        config.text = value
        config.textProperties.color = .white
        cell.contentConfiguration = config

        cell.backgroundColor = .clear
        cell.accessoryType = value == selected ? .checkmark : .none
        cell.tintColor = .systemBlue

        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let value = items[indexPath.row]
        onSelect?(value)
        dismiss(animated: true)
    }
}
