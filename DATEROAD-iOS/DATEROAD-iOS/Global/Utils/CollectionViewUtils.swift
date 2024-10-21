//
//  CollectionViewUtils.swift
//  DATEROAD-iOS
//
//  Created by 김민서 on 9/18/24.
//

import UIKit

class CollectionViewUtils {
    
    func dequeueAndConfigureCell<T: UICollectionViewCell>(collectionView: UICollectionView, indexPath: IndexPath, identifier: String, configure: (T) -> Void) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return UICollectionViewCell()
        }
        configure(cell)
        return cell
    }
    
    func dequeueAndConfigureSupplementaryView<T: UICollectionReusableView>(collectionView: UICollectionView, indexPath: IndexPath, kind: String, identifier: String, configure: (T) -> Void) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            return UICollectionReusableView()
        }
        configure(view)
        return view
    }
    
}


