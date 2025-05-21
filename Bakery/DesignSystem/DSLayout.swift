//
//  DSLayout.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 07.05.2025.
//

import CoreFoundation

struct DSLayoutMarging {
    var width: DSWidth = .auto
    var height: DSHeight = .auto
    
    var hAlign: DSAlign = .auto
    var vAlign: DSAlign = .auto
    
    var topMargin: CGFloat? = nil
    var bottomMargin: CGFloat? = nil
    var leftMargin: CGFloat? = nil
    var rightMargin: CGFloat? = nil
    
    init(width: DSWidth = .auto,height: DSHeight = .auto, hAlign: DSAlign = .auto, vAlign: DSAlign = .auto, topMargin: VSpacing?  = nil, bottomMargin: VSpacing?  = nil, HMargin: HSpacing?  = nil, leftMargin: HSpacing?  = nil, rightMargin: HSpacing?  = nil) {
        self.width = width
        self.height = height
        self.hAlign = hAlign
        self.vAlign = vAlign
        
        if let mrg = topMargin{
            self.topMargin = mrg.rawValue
        }
        
        if let mrg = bottomMargin{
            self.bottomMargin = mrg.rawValue
        }
        
        if let mrg = HMargin{
            self.leftMargin = mrg.rawValue
            self.rightMargin = mrg.rawValue
        }
        
        if let mrg = leftMargin{
            self.leftMargin = mrg.rawValue
        }
        
        if let mrg = rightMargin{
            self.rightMargin = mrg.rawValue
        }
    }
}

struct DSLayoutPadding {
    var vPadding: CGFloat = .zero
    var hPadding: CGFloat = .zero
    
    init(VPadding: VSpacing = .zero, HPadding: HSpacing = .zero) {
        self.vPadding = VPadding.rawValue
        self.hPadding = HPadding.rawValue
    }
}


struct DSLayout {
    
    var margin: DSLayoutMarging = .init()
    var padding: DSLayoutPadding = .init()
    
    init(margin: DSLayoutMarging = .init(), padding: DSLayoutPadding = .init()) {
        self.margin = margin
        self.padding = padding
    }
}

enum DSWidth: Equatable {
    case `auto`
    case fill
    case fixed(CGFloat)
}

enum DSHeight: Equatable {
    case `auto`
    case fixed(CGFloat)
}

enum DSAlign {
    case `auto`
    case center
}
