//
//  DSImageTest.swift
//  BakeryTests
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Testing
import UIKit
@testable import Bakery

struct DSImageTest {

    @Test
    func testJsonMapperImpl() {
        
        let transfer_image: UIImage = .points
        let data = transfer_image.toBase64() ?? ""
        
        let json = """
        {
            "componentType": "image",
            "identifier": "my_image",
            "size": "icon",
            "imageBase64": "\(data)",
            "layout": {
                "margin": {
                    "width": "auto",
                    "height": "fixed(50)",
                    "hAlign": "auto",
                    "vAlign": "center",
                    "topMargin": "zero",
                    "bottomMargin": "xs",
                    "HMargin": "s",
                    "leftMargin": "m",
                    "rightMargin": "l"

                },
                "padding": {
                    "hPadding": "m",
                    "vPadding": "s"
                }
            }
        }
        """.data(using: .utf8)!
        
        var (my_view, _) = JsonMapperImpl.map(jsonData: json)
        
        guard let viewModel = my_view as? DSImageViewModel else {
            #expect(false, "my_view is not a DSImageViewModel")
            return
        }
        
        #expect(viewModel.identifier == "my_image", "id should be 'my_image'")
        #expect(viewModel.size == .icon, "Size should be 'icon'")
        #expect(viewModel.image?.pngData() == transfer_image.pngData(), "Image should be equal")
        
        #expect(viewModel.layout.margin.width == .auto, "Margin width should be 'auto'")
        #expect(viewModel.layout.margin.height == .fixed(50), "Margin height should be 'fixed(50)'")
        #expect(viewModel.layout.margin.hAlign == .auto, "Margin hAlign should be 'auto'")
        #expect(viewModel.layout.margin.vAlign == .center, "Margin vAlign should be 'center'")
        #expect(viewModel.layout.margin.topMargin == .zero, "Margin topMargin should be 'zero'")
        #expect(viewModel.layout.margin.bottomMargin == VSpacing.xs.rawValue, "Margin bottomMargin should be 'xs'")
        #expect(viewModel.layout.margin.leftMargin == HSpacing.m.rawValue, "Margin leftMargin should be 'm'")
        #expect(viewModel.layout.margin.rightMargin == HSpacing.l.rawValue, "Margin rightMargin should be 'l'")
        
        #expect(viewModel.layout.padding.hPadding == HSpacing.m.rawValue, "Padding hPadding should be 'm'")
        #expect(viewModel.layout.padding.vPadding == VSpacing.s.rawValue, "Padding vPadding should be 's'")
    }


}
