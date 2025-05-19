//
//  ActionHandler.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Foundation

// Просто шаблонные классы нельзя сделать статичными, поэтому такой мув
fileprivate enum SharedStore {
    private static var instances: [ObjectIdentifier: Any] = [:]
    private static let queue = DispatchQueue(label: "shared.store.queue", attributes: .concurrent)

    static func instance<T>(for type: T.Type) -> ActionHandler<T> {
        let key = ObjectIdentifier(type)
        
        if let existing = queue.sync(execute: { instances[key] as? ActionHandler<T> }) {
            return existing
        }
        
        return queue.sync(flags: .barrier) {
            if let existing = instances[key] as? ActionHandler<T> {
                return existing
            }
            
            let newInstance = ActionHandler<T>()
            instances[key] = newInstance
            return newInstance
        }
    }
}

final class ActionHandler<T> {
    static func shared() -> ActionHandler<T> {
        return SharedStore.instance(for: T.self)
    }
    
    private var custom_handlers: [String: (T) -> Void] = [:]
    private var route_handlers: [String: (T) -> Void] = [:]
    private let queue = DispatchQueue(label: "action.handler.queue", attributes: .concurrent)
    
    func registerHandler(for model: HandlerModel, handler: @escaping (T) -> Void) {
        queue.async(flags: .barrier) {
            switch model.type {
            case .route:
                guard let target = model.target else { return }
                self.route_handlers[target] = handler
            case .custom:
                guard let handler_name = model.handler_name else { return }
                self.custom_handlers[handler_name] = handler
            }
        }
    }
    
    func getHandler(action: HandlerModel) -> ((T) -> Void)? {
        queue.sync {
            switch action.type {
            case .route:
                guard let target = action.target else { return nil }
                return self.route_handlers[target]
                
            case .custom:
                guard let handler_name = action.handler_name else { return  nil }
                return self.custom_handlers[handler_name]
            }
        }
    }
}

extension ActionHandler where T == Void {
   
    func registerHandler(for model: HandlerModel, handler: @escaping () -> Void) {
        registerHandler(for: model) { (_: Void) in handler() }
    }
    
    func getHandler(action: HandlerModel) -> (() -> Void)? {
        return getHandler(action: action).map { h in { h(()) } }
    }
}

struct HandlerModel: Decodable {
    enum ActionType: String, Decodable {
        case route, custom
    }
    
    let type: ActionType
    let handler_name: String?
    let target: String?
//    let customData: [String: Any]?
    
    init(route target: String){
        self.type = .route
        self.target = target
        self.handler_name = nil
    }
    
    init(custom name: String){
        self.type = .custom
        self.handler_name = name
        self.target = nil
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(ActionType.self, forKey: .type)
        
        handler_name = try container.decodeIfPresent(String.self, forKey: .handler_name)
        target = try container.decodeIfPresent(String.self, forKey: .target)
    }
    
    enum CodingKeys: String, CodingKey {
        case type, handler_name, target, customData
    }
}
