//
//  File.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 09.04.2025.
//

typealias UniqueIdentifier = String

/// Протокол определяющий поведение объектов идентфицируемых уникально
protocol UniqueIdentifiable {
    var uid: UniqueIdentifier { get }
}
