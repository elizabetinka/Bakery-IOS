//
//  AuthChekerWorker.swift
//  Bakery
//
//  Created by Елизавета Кравченкова on 10.04.2025.
//

import Foundation


enum UserWorkerError: Error {
    case getInfoFailed(underlyingError: Error)
}


protocol AuthChekerWorker {
    func isAuth(completion: @escaping (Bool?, UserWorkerError?) -> Void)
}


struct WorkerUserInfo {
    let name: String
    let points: Int
    let phoneNumner: String
}

protocol UserWorker {
    func getInfo(completion: @escaping (WorkerUserInfo?, UserWorkerError?) -> Void)
}

