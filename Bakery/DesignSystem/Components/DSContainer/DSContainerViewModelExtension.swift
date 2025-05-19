//
//  DSButtonViewModelExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.05.2025.
//


extension DSContainerViewModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier, layout, items, topView, bottomView
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(String.self, forKey: .identifier)
        topView = try container.decode(Int.self, forKey: .topView)
        bottomView = try container.decode(Int.self, forKey: .bottomView)
        layout = try container.decode(DSLayout.self, forKey: .layout)
        let decodedItems = try container.decode([DSViewModelWrapper].self, forKey: .items)
        items = decodedItems.map { $0.viewModel }
    }
}
