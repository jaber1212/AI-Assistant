//
//  SourcesListView.swift
//  AI-Assistant
//
//  Created by M.jaber on 25/12/2025.
//

import Foundation
import UIKit

final class SourcesListView: UIView {

    private let collectionView: UICollectionView

    private let sources: [Source] = [
        Source(name: "HDMI Cable", image: UIImage(named: "as1"), isActive: true),
        Source(name: "Clickshare", image: UIImage(named: "as2"), isActive: false),
        Source(name: "Apple TV", image: UIImage(named: "as3"), isActive: false),
        Source(name: "MTR", image: UIImage(named: "as4"), isActive: false)
    ]

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 220, height: 120)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self

        collectionView.register(SourceItemCell.self, forCellWithReuseIdentifier: "SourceItemCell")

        addSubview(collectionView)
    }

    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension SourcesListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sources.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SourceItemCell",
            for: indexPath
        ) as! SourceItemCell

        cell.configure(with: sources[indexPath.item])
        return cell
    }
}
