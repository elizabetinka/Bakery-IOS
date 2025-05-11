//
//  ModuleBuilder.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 09.04.2025.
//

import Foundation
import UIKit

protocol ModuleBuilder {
    @MainActor
    func build() -> UIViewController
}
