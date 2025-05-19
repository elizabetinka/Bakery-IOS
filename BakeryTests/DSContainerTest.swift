//
//  DSStackTest.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Testing
@testable import Bakery

struct DSContainerTest {

    @Test
    func testJsonMapperImpl() {
        let json = """
        {
            "componentType": "container",
            "identifier": "my-container",
            "topView": 0,
            "bottomView": 2,
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
            "items": [
                {
                    "componentType": "activityIndicator",
                    "identifier": "my_activityIndicator",
                    "style": "primary",
                    "size": "large",
                    "state": "running",
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
                },
                {
                    "componentType": "spacer",
                    "identifier": "my_spacer",
                    "minHeight": 20,
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
                },
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
                        "handler_name": "printerContainer"
                    }
                }
            ]
        }
        """.data(using: .utf8)!
        
        var didPerformAction = false
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(custom: "printerContainer"), handler: {
            didPerformAction = true
        })
        var (my_view, _) = JsonMapperImpl.map(jsonData: json)
        
        guard let viewModel = my_view as? DSContainerViewModel else {
            #expect(false, "my_view is not a DSContainerViewModel")
            return
        }

        #expect(viewModel.identifier == "my-container", "id should be 'my-container'")
        #expect(viewModel.topView == 0, "topView should be '0'")
        #expect(viewModel.bottomView == 2, "bottomView should be '2'")
        
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
        
        
        
        #expect(viewModel.items.count==3, "Items count should be 3")
        
        #expect(viewModel.items[0].identifier == "my_activityIndicator", "First item identifier should be 'my_activityIndicator'")
        #expect(viewModel.items[1].identifier == "my_spacer", "Second item identifier should be 'my_spacer'")
        #expect(viewModel.items[2].identifier == "button", "Third item identifier should be 'button'")
        
        guard let buttonViewModel = viewModel.items[2] as? DSButtonViewModel else {
            #expect(false, "Third item identifier should be 'DSButtonViewModel")
            return
        }
        #expect(didPerformAction == false, "Action should not be performed")
        buttonViewModel.onTap?()
        #expect(didPerformAction == true, "Action should be performed")
    }

}
