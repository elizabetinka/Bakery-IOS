//
//  File.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation
import UIKit

class CommonTableDelegate: NSObject, UITableViewDelegate {

    weak var delegate: CommonViewControllerDelegate?

    var representableViewModel: CommonViewModel?

    init(viewModel: CommonViewModel? = nil) {
        representableViewModel = viewModel
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }

        guard let viewModel = representableViewModel else { return }
        
        if (indexPath.section == 0){
            delegate?.openUser()
        }
        else if (indexPath.section == 1){
            delegate?.openMenu()
        }
    }
}
