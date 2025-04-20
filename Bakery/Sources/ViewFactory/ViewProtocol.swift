//
//  ViewProtocol.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 17.04.2025.
//

@MainActor
protocol ViewProtocol {
    func showLoading()
    func showError(message: String)
    func stopError()
}
