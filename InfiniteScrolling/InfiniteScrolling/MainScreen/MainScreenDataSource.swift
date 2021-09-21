//
//  MainScreenDataSource.swift
//  InfiniteScrolling
//
//  Created by macuser on 21.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___ All rights reserved.
//

import UIKit

final class MainScreenDataSource {

    // TODO: remove typealias or DataSource class from this file
    fileprivate typealias DataSource = UICollectionViewDiffableDataSource<MainScreen.Models.Section, MainScreen.Models.Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<MainScreen.Models.Section, MainScreen.Models.Item>

    // MARK: - Properties
    private let collectionView: UICollectionView
    private lazy var dataSource = makeDataSource()

    // MARK: - Initializators
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.collectionViewLayout = makeLayout()
        collectionView.dataSource = dataSource
        makeSupplementaryProvider()
        registerReusable(in: collectionView)
    }

    // MARK: - Interface
    func updateSnapshot(_ items: [MainScreen.Models.Item], animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

// MARK: - Private
private extension MainScreenDataSource {

    func registerReusable(in collectionView: UICollectionView) {
//        collectionView.register(cellType: MyCollectionCell.self)
//        collectionView.register(supplementaryViewType: MySectionView.self, ofKind: MySectionView.reuseIdentifier)
    }
}

// MARK: - DataSource
private extension MainScreenDataSource {

    func makeDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            switch item {
            }
        }
    }

    func makeSupplementaryProvider() {
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            return nil
//            guard let self = self else { return  nil }
//
//            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
//            switch section {
//
//            }
        }
    }
}

// MARK: - Layout
private extension MainScreenDataSource {

    func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] index, _ -> NSCollectionLayoutSection? in
            return nil
        }
    }
}

// MARK: - DataSource class
//private extension MainScreenDataSource {
//
//    final class DataSource: UICollectionViewDiffableDataSource<MainScreen.Models.Section, MainScreen.Models.Item>,
//                            SkeletonCollectionViewDataSource {
//
//        func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
//
//        }
//    }
//}
