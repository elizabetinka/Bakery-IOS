//
//  DSButtonTest.swift
//  BakeryTests
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Testing
@testable import Bakery

struct DSButtonTest {

    @Test
    func testJsonMapperImpl() {
        let json = """
        {
            "componentType": "button",
            "identifier": "button",
            "title": "Submit",
            "style": "primary",
            "size": "medium",
            "state": "default",
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
            },
            "action": {
                "type": "custom",
                "handler_name": "printerButton"
            }
        }
        """.data(using: .utf8)!
        
        var didPerformAction = false
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(custom: "printerButton"), handler: {
            didPerformAction = true
        })
        var (my_view, _) = JsonMapperImpl.map(jsonData: json)
        
        guard let buttonViewModel = my_view as? DSButtonViewModel else {
            #expect(false, "my_view is not a DSButtonViewModel")
            return
        }

        #expect(buttonViewModel.title == "Submit", "Title should be 'Submit'")
        #expect(buttonViewModel.style == .primary, "Style should be 'primary'")
        #expect(buttonViewModel.size == .medium, "Size should be 'medium'")
        #expect(buttonViewModel.state == .default, "State should be 'default'")
        
        #expect(buttonViewModel.layout.margin.width == .auto, "Margin width should be 'auto'")
        #expect(buttonViewModel.layout.margin.height == .fixed(50), "Margin height should be 'fixed(50)'")
        #expect(buttonViewModel.layout.margin.hAlign == .auto, "Margin hAlign should be 'auto'")
        #expect(buttonViewModel.layout.margin.vAlign == .center, "Margin vAlign should be 'center'")
        #expect(buttonViewModel.layout.margin.topMargin == .zero, "Margin topMargin should be 'zero'")
        #expect(buttonViewModel.layout.margin.bottomMargin == VSpacing.xs.rawValue, "Margin bottomMargin should be 'xs'")
        #expect(buttonViewModel.layout.margin.leftMargin == HSpacing.m.rawValue, "Margin leftMargin should be 'm'")
        #expect(buttonViewModel.layout.margin.rightMargin == HSpacing.l.rawValue, "Margin rightMargin should be 'l'")
        
        #expect(buttonViewModel.layout.padding.hPadding == HSpacing.m.rawValue, "Padding hPadding should be 'm'")
        #expect(buttonViewModel.layout.padding.vPadding == VSpacing.s.rawValue, "Padding vPadding should be 's'")
        
        #expect(didPerformAction == false, "Action should not be performed")
        buttonViewModel.onTap?()
        #expect(didPerformAction == true, "Action should be performed")
    }

}
