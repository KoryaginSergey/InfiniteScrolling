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
        //    self.collectionView = collectionView
        //    collectionView.collectionViewLayout = makeLayout()
        //    collectionView.dataSource = dataSource
        //    registerReusable(in: collectionView)
        
        
        self.collectionView = collectionView
        registerReusable(in: collectionView)
        collectionView.collectionViewLayout = makeLayout()
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        
        
        
        
    }
    
    // MARK: - Interface
    func updateSnapshot(_ sections: [MainScreen.Models.Section], animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach {
            snapshot.appendItems($0.items, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

//func updateSnapshot(_ sections: [BSDashboard.Models.Section], animated: Bool = true) {
//       var snapshot = Snapshot()
//
//       snapshot.appendSections(sections)
//       sections.forEach {
//           snapshot.appendItems($0.items, toSection: $0)
//       }
//
//       dataSource.apply(snapshot, animatingDifferences: animated)
//   }

// MARK: - Private
private extension MainScreenDataSource {
    
    func registerReusable(in collectionView: UICollectionView) {
        collectionView.register(cellType: TopCollectionViewCell.self)
        collectionView.register(cellType: BottomCollectionViewCell.self)
        //        collectionView.register(supplementaryViewType: MySectionView.self, ofKind: MySectionView.reuseIdentifier)
    }
}

// MARK: - DataSource
private extension MainScreenDataSource {
    
    func makeDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            switch item {
            case .topItem(state: let state):
                let cell: TopCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.state = state
                return cell
            case .bottomItem(state: let state):
                let cell: BottomCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.state = state
                return cell
            }
        }
    }
    
    //    func makeSupplementaryProvider() {
    //        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
    //            return nil
    ////            guard let self = self else { return  nil }
    ////
    ////            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
    ////            switch section {
    ////
    ////            }
    //        }
    //    }
}

// MARK: - Layout
private extension MainScreenDataSource {
    
    func makeLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] index, _ -> NSCollectionLayoutSection? in
            switch index  {
            case 0: return self?.firstLayoutSection()
            case 1: return self?.secondLayoutSection()
            default: return self?.firstLayoutSection()
            }
        }
    }
    
    //  func makeLayout() -> UICollectionViewCompositionalLayout {
    //
    //    return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
    //      switch sectionNumber {
    //      case 0: return self.firstLayoutSection()
    //      case 1: return self.secondLayoutSection()
    //      default: return self.secondLayoutSection()
    //      }
    //    }
    //  }
    
    //  func makeLayout() -> NSCollectionLayoutSection? {
    //    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)))
    //    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)),
    //                                                   subitems: [item])
    //    let section = NSCollectionLayoutSection(group: group)
    //
    //    return section
    //  }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets()
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func secondLayoutSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets()
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        //    section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    //  private func createLayout() -> UICollectionViewCompositionalLayout {
    //      let itemSize = NSCollectionLayoutSize(
    //        widthDimension: .fractionalWidth(1.0),
    //        heightDimension: .fractionalHeight(1.0))
    //      let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //
    //      let groupSize = NSCollectionLayoutSize(
    //          widthDimension: .fractionalWidth(1.0),
    //        heightDimension: .absolute(collectionView.frame.size.height / 2))
    //      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    //
    //      let section = NSCollectionLayoutSection(group: group)
    //      let layout = UICollectionViewCompositionalLayout(section: section)
    //      return layout
    //  }
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
