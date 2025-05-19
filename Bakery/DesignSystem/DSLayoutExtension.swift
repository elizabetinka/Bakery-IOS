//
//  DSLayoutExtension.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 18.05.2025.
//

import CoreFoundation

extension DSWidth: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "auto": self = .auto
        case "fill": self = .fill
        default:
            if value.starts(with: "fixed(") {
                let cleanValue = value
                    .replacingOccurrences(of: "fixed(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                
                guard let doubleValue = Double(cleanValue) else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Invalid fixed width value"
                    )
                }
            self = .fixed(CGFloat(doubleValue))
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Unknown width type"
                )
            }
        }
    }
}

extension DSHeight: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "auto": self = .auto
        default:
            if value.starts(with: "fixed(") {
                let cleanValue = value
                    .replacingOccurrences(of: "fixed(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                
                guard let doubleValue = Double(cleanValue) else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Invalid fixed height value"
                    )
                }
            self = .fixed(CGFloat(doubleValue))
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Unknown height type"
                )
            }
        }
    }
}

extension DSAlign: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case "auto": self = .auto
        case "center": self = .center
        default: throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Unknown align type"
        )
        }
    }
}
extension HSpacing: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "zero": self = .zero
        case "xs": self = .xs
        case "s": self = .s
        case "m": self = .m
        case "l": self = .l
        case "xl": self = .xl
        default:
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid HSpacing value: \(value)"
            )
        }
    }
}

extension VSpacing: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "zero": self = .zero
        case "xs": self = .xs
        case "s": self = .s
        case "m": self = .m
        case "l": self = .l
        case "xl": self = .xl
        case "xxl": self = .xxl
        default:
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid VSpacing value: \(value)"
            )
        }
    }
}



extension DSLayoutPadding: Decodable {
    enum CodingKeys: String, CodingKey {
        case vPadding
        case hPadding
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let vPadding = try container.decodeIfPresent(VSpacing.self, forKey: .vPadding) ?? .zero
        let hPadding = try container.decodeIfPresent(HSpacing.self, forKey: .hPadding) ?? .zero
        
        self.init(VPadding: vPadding, HPadding: hPadding)
    }
}

extension DSLayoutMarging: Decodable {
    enum CodingKeys: String, CodingKey {
        case width, height
        case hAlign, vAlign
        case topMargin, bottomMargin
        case HMargin, leftMargin, rightMargin
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Обязательные параметры
        let width = try container.decode(DSWidth.self, forKey: .width)
        let height = try container.decode(DSHeight.self, forKey: .height)
        let hAlign = try container.decode(DSAlign.self, forKey: .hAlign)
        let vAlign = try container.decode(DSAlign.self, forKey: .vAlign)
        
        // Обработка отступов
        var topMargin: VSpacing?
        var bottomMargin: VSpacing?
        var HMargin: HSpacing?
        var leftMargin: HSpacing?
        var rightMargin: HSpacing?
        
        topMargin = try container.decodeIfPresent(VSpacing.self, forKey: .topMargin)
        bottomMargin = try container.decodeIfPresent(VSpacing.self, forKey: .bottomMargin)
        HMargin = try container.decodeIfPresent(HSpacing.self, forKey: .HMargin)
        leftMargin = try container.decodeIfPresent(HSpacing.self, forKey: .leftMargin)
        rightMargin = try container.decodeIfPresent(HSpacing.self, forKey: .rightMargin)
        
        self.init(
            width: width,
            height: height,
            hAlign: hAlign,
            vAlign: vAlign,
            topMargin: topMargin,
            bottomMargin: bottomMargin,
            HMargin: HMargin,
            leftMargin: leftMargin,
            rightMargin: rightMargin
        )
    }
}

extension DSLayout: Decodable {
    enum CodingKeys: String, CodingKey {
        case margin, padding
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let margin = try container.decodeIfPresent(DSLayoutMarging.self, forKey: .margin) ?? .init()
        let padding = try container.decodeIfPresent(DSLayoutPadding.self, forKey: .padding) ?? .init()
        
        self.init(margin: margin, padding: padding)
    }
}

