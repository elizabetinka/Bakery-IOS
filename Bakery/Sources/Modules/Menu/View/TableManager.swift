//
//  TableManager.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 20.04.2025.
//

import Foundation
import UIKit

protocol CollectionManagerDelegate: AnyObject {
    func didUpdateData()
    func openItemTapped(_ itemId: UniqueIdentifier)
}

protocol CollectionManagerProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    func updateData(with viewModels: [ItemViewModel])
    
    var delegate: CollectionManagerDelegate? { get set }
}

class CollectionManager: NSObject, CollectionManagerProtocol {
    
    weak var delegate: CollectionManagerDelegate?
    private var representableViewModel: [ItemViewModel]

    init(viewModel: [ItemViewModel] = []) {
        representableViewModel = viewModel
    }

    func updateData(with viewModels: [ItemViewModel]) {
        self.representableViewModel = viewModels
        delegate?.didUpdateData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer {collectionView.deselectItem(at: indexPath, animated: true)}
        
        guard let viewModel = representableViewModel[safe: indexPath.row] else { return }
        delegate?.openItemTapped(viewModel.uid)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return representableViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell<CardView>.reuseIdentifier,  for: indexPath) as! CollectionCell<CardView>
        let item = representableViewModel[indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
}
