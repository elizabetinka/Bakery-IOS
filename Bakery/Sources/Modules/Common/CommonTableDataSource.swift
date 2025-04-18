//
//  File.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit


class CommonTableDataSource: NSObject, UITableViewDataSource {
    var representableViewModel: CommonViewModel

    init(viewModel: CommonViewModel = CommonViewModel(user: nil,item: nil)) {
        representableViewModel = viewModel
    }
    
    func setUserModel(_ viewModel: CommonUserViewModel?) {
        representableViewModel.user = viewModel
    }
    
    func setItemModel(_ viewModel: CommonItemViewModel?) {
        representableViewModel.item = viewModel
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: UserCell.reuseIdentifier,
                for: indexPath) as! UserCell
            guard let viewModel = representableViewModel.user else { return cell }
            cell.configure(with: viewModel)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MenuCell.reuseIdentifier,
                for: indexPath) as! MenuCell
            guard let viewModel = representableViewModel.item else { return cell }
            cell.configure(with: viewModel)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
