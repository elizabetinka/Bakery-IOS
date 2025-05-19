//
//  DSStackAligment.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 09.05.2025.
//

import UIKit

enum DSStackAlignment{
    case center
    case equal
    
    
    public var distribution: UIStackView.Distribution {
        switch (self) {
        case .center: return .fill
        case .equal: return .fillEqually
        }
    }
    
    func alignment() -> UIStackView.Alignment {
        switch (self) {
        case .center: return .center
        case .equal: return .fill
        }
    }

}
