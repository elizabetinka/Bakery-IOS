//
//  DSLayout.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 07.05.2025.
//

import CoreFoundation

struct DSLayoutMarging {
    var width: DSWidth
    var height: DSHeight
    
    var hAlign: DSAlign
    var vAlign: DSAlign
    
    var topMargin: CGFloat? = nil
    var bottomMargin: CGFloat? = nil
    var leftMargin: CGFloat? = nil
    var rightMargin: CGFloat? = nil
    
//    init(width: DSWidth = .fill, hAlign: DSAlign = .auto, vAlign: DSAlign = .auto, topMargin: CGFloat?  = nil, bottomMargin: CGFloat?  = nil, HMargin: CGFloat?  = nil) {
//        self.width = width
//        self.hAlign = hAlign
//        self.vAlign = vAlign
//        self.topMargin = topMargin
//        self.bottomMargin = bottomMargin
//        self.hMargin = HMargin
//    }
    
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
    var vPadding: CGFloat
    var hPadding: CGFloat
    
    init(VPadding: VSpacing = .zero, HPadding: HSpacing = .zero) {
        self.vPadding = VPadding.rawValue
        self.hPadding = HPadding.rawValue
    }
}


struct DSLayout {
    
    var margin: DSLayoutMarging
    var padding: DSLayoutPadding
    
    init(margin: DSLayoutMarging = .init(), padding: DSLayoutPadding = .init()) {
        self.margin = margin
        self.padding = padding
    }
}

//struct DSLayout {
//    var width: DSWidth
//    
//    var hAlign: DSAlign
//    var vAlign: DSAlign
//    
//    var topMargin: CGFloat?
//    var bottomMargin: CGFloat?
//    var hMargin: CGFloat?
//    
//    var vPadding: CGFloat
//    var hPadding: CGFloat
//    
//    init(width: DSWidth = .fill, hAlign: DSAlign = .auto, vAlign: DSAlign = .auto, topMargin: CGFloat?  = nil, bottomMargin: CGFloat?  = nil, HMargin: CGFloat?  = nil, VPadding: CGFloat  = VSpacing.zero, HPadding: CGFloat  = HSpacing.zero) {
//        self.width = width
//        self.hAlign = hAlign
//        self.vAlign = vAlign
//        self.topMargin = topMargin
//        self.bottomMargin = bottomMargin
//        self.hMargin = HMargin
//        self.vPadding = VPadding
//        self.hPadding = HPadding
//    }
//}

