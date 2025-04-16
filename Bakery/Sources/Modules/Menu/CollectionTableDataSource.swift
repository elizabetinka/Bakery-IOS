//
//  File.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit


class MenuCollectionDataSource: NSObject, UICollectionViewDataSource {
    var representableViewModel: [ItemViewModel]

    init(viewModel: [ItemViewModel] = []) {
        representableViewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return representableViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseId, for: indexPath) as! ItemCell
        let item = representableViewModel[indexPath.item]
        cell.configure(with: item)
        return cell
    }

}
