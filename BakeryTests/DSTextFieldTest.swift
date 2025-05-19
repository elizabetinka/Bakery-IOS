//
//  DSButtonTest.swift
//  BakeryTests
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Testing
@testable import Bakery

struct DSTextFieldTest {

    @Test
    func testJsonMapperImpl() {
        let json = """
        {
            "componentType": "text",
            "identifier": "my-text-field",
            "text": "some text",
            "placeholder": "placeholder-text",
            "size": "medium",
            "state": "error",
            "style": "placeholder",
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
                "handler_name": "printerTextField"
            },
            "errorLabel": {
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
                        "rightMargin": "l"
                    },
                    "padding": {
                        "hPadding": "m",
                        "vPadding": "s"
                    }
                }
            }
        }
        """.data(using: .utf8)!

        var performAction = ""
        ActionHandler<String>.shared().registerHandler(for: HandlerModel(custom: "printerTextField"), handler: {string in
            performAction = string
        })
        
        var (my_view, _) = JsonMapperImpl.map(jsonData: json)
        
        guard let viewModel = my_view as? DSTextFieldViewModel else {
            #expect(false, "my_view is not a DSTextFieldViewModel")
            return
        }
        
        #expect(viewModel.identifier == "my-text-field", "identifier should be 'my-text-field'")
        #expect(viewModel.text == "some text", "Title should be 'some text'")
        #expect(viewModel.placeholder == "placeholder-text", "Placeholder should be 'placeholder-text'")
        #expect(viewModel.style == .placeholder, "Style should be 'placeholder'")
        #expect(viewModel.size == .medium, "Size should be 'medium'")
        #expect(viewModel.state == .error, "State should be 'error'")
        
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
        
        #expect(performAction.isEmpty, "Action should not be performed")
        viewModel.onEditingChanged?("Лизонька")
        #expect(performAction == "Лизонька", "Action should be performed")
        
        
        
        #expect(viewModel.errorLabel.text == "Привет!!!!", "Title should be 'Привет!!!!'")
        #expect(viewModel.errorLabel.style == .beautyful, "Style should be 'beautyful'")
        #expect(viewModel.errorLabel.size == .l, "Size should be 'l'")
        #expect(viewModel.errorLabel.state == .hidden, "State should be 'hidden'")
        
        #expect(viewModel.errorLabel.layout.margin.width == .auto, "Margin width should be 'auto'")
        #expect(viewModel.errorLabel.layout.margin.height == .fixed(50), "Margin height should be 'fixed(50)'")
        #expect(viewModel.errorLabel.layout.margin.hAlign == .auto, "Margin hAlign should be 'auto'")
        #expect(viewModel.errorLabel.layout.margin.vAlign == .center, "Margin vAlign should be 'center'")
        #expect(viewModel.errorLabel.layout.margin.topMargin == .zero, "Margin topMargin should be 'zero'")
        #expect(viewModel.errorLabel.layout.margin.bottomMargin == VSpacing.xs.rawValue, "Margin bottomMargin should be 'xs'")
        #expect(viewModel.errorLabel.layout.margin.leftMargin == HSpacing.m.rawValue, "Margin leftMargin should be 'm'")
        #expect(viewModel.errorLabel.layout.margin.rightMargin == HSpacing.l.rawValue, "Margin rightMargin should be 'l'")
        
        #expect(viewModel.errorLabel.layout.padding.hPadding == HSpacing.m.rawValue, "Padding hPadding should be 'm'")
        #expect(viewModel.errorLabel.layout.padding.vPadding == VSpacing.s.rawValue, "Padding vPadding should be 's'")
    }

}
