//
//  ViewController.swift
//  Collection
//
//  Created by 이시원 on 2022/05/11.
//

import UIKit

enum Section: Int, CaseIterable, Hashable {
    case main
    case seconde
    case third
}

typealias DataSource = UICollectionViewDiffableDataSource<Section, String>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

class ViewController: UIViewController {
    let collectionList = ["swift",
                          "pencil",
                          "scribble",
                          "highlighter",
                          "lasso",
                          "folder",
                          "paperplane",
                          "note",
                          "magazine",
                          "lanyardcard",
                          "command",
                          "rosette",
                          "link",
                          "person",
                          "lineweight",
                          "restart",
                          "sleep",
                          "escape",
                          "option"]
    
    let ccc = ["ss","sss","ssss"]
    let cccc = ["cc","ccc","cccc"]
    lazy var dataSource = makeDataSource()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.collectionViewLayout = configureGridLayout()
        applySnapshot()
    }
}

extension ViewController {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
            
            cell.backgroundColor = .lightGray
            cell.label.text = itemIdentifier
            cell.imageView.image = UIImage(systemName: itemIdentifier)
            cell.layer.cornerRadius = 10
            cell.backgroundColor = .white
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.gray.cgColor
            print("sss")
            
            return cell
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "hhh", for: indexPath)
            
            //let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            return view
            
        }
        
        return dataSource
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(collectionList, toSection: .main)
        snapshot.appendItems(ccc, toSection: .seconde)
        snapshot.appendItems(cccc, toSection: .third)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let width = collectionView.bounds.width / 2 - 16
    //        let size = CGSize(width: width, height: width * 1.3)
    //        return size
    //    }
    
    private func configureGridLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionNumber) else { return nil }
            
            if sectionKind == .main {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200)), subitems: [item])
                group.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                return section
            } else if sectionKind == .seconde {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
                item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.45), heightDimension: .estimated(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(300)), subitem: item, count: 5)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                return section
            }
        }
    }
    
    func getItemLayout(widthDimension: NSCollectionLayoutDimension, heightDimension: NSCollectionLayoutDimension) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        return item
    }
}

//extension ViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "hhh", for: indexPath)
//            return header
//        } else {
//            return UICollectionReusableView()
//        }
//    }
//}



