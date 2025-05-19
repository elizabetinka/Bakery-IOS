//
//  DSButtonTest.swift
//  BakeryTests
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Testing
@testable import Bakery


struct DSLabelTest {

    @Test
    func testJsonMapperImpl() {
        let json = """
        {
            "componentType": "label",
            "identifier": "my_label",
            "text": "Привет!!!!",
            "style": "beautyful",
            "size": "l",
            "state": "hidden",
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
                    "rightMargin": "l",

                },
                "padding": {
                    "hPadding": "m",
                    "vPadding": "s"
                }
            }
        }
        """.data(using: .utf8)!
        
        var (my_view, _) = JsonMapperImpl.map(jsonData: json)
        
        guard let viewModel = my_view as? DSLabelViewModel else {
            #expect(false, "my_view is not a DSLabelViewModel")
            return
        }
        
        #expect(viewModel.text == "Привет!!!!", "Title should be 'Привет!!!!'")
        #expect(viewModel.style == .beautyful, "Style should be 'beautyful'")
        #expect(viewModel.size == .l, "Size should be 'l'")
        #expect(viewModel.state == .hidden, "State should be 'hidden'")
        
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
