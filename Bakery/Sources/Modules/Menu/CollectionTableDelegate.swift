//
//  File.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit

class MenuCollectionDelegate: NSObject, UICollectionViewDelegate {

    weak var delegate: MenuViewControllerDelegate?

    var representableViewModel: [ItemViewModel]

    init(viewModel: [ItemViewModel] = []) {
        representableViewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer {collectionView.deselectItem(at: indexPath, animated: true)}
        
        guard let viewModel = representableViewModel[safe: indexPath.row] else { return }
        delegate?.openItemDetails(viewModel.uid)
    }

}
