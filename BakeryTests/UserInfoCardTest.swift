//
//  UserInfoCardTest.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Testing
@testable import Bakery

struct UserInfoCardTest {

    @Test
    func testJsonMapperImpl() {
        let json = """
        {
            "componentType": "userInfoCard",
            "identifier": "my-userInfoCard",
            "style": "primary",
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
            "valueLabel": 
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
            },
            "headerStack":
            {
                "componentType": "stack",
                "identifier": "my-stack",
                "alignment": "equal",
                "style": "vertical",
                "size": "m",
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
                            "handler_name": "printerInfoCard"
                        }
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        var didPerformAction = false
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(custom: "printerInfoCard"), handler: {
            didPerformAction = true
        })
        var (my_view, _) = JsonMapperImpl.map(jsonData: json)
        
        guard let viewModel = my_view as? UserInfoCardModelViewModel else {
            #expect(false, "my_view is not a UserInfoCardModelViewModel")
            return
        }

        #expect(viewModel.identifier == "my-userInfoCard", "id should be 'my-userInfoCard'")
        #expect(viewModel.style == .primary, "State should be 'primary'")
        
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
        
        
        
        
        
        guard let stackModel = viewModel.headerStack as? DSStackViewModel else {
            #expect(false, "my_view is not have DSStackViewModel")
            return
        }

        #expect( stackModel.identifier == "my-stack", "id should be 'my-stack'")
        #expect( stackModel.alignment == .equal, "Style should be 'equal'")
        #expect( stackModel.size == .m, "Size should be 'm'")
        #expect( stackModel.style == .vertical, "State should be 'vertical'")
        
        #expect( stackModel.layout.margin.width == .auto, "Margin width should be 'auto'")
        #expect( stackModel.layout.margin.height == .fixed(50), "Margin height should be 'fixed(50)'")
        #expect( stackModel.layout.margin.hAlign == .auto, "Margin hAlign should be 'auto'")
        #expect( stackModel.layout.margin.vAlign == .center, "Margin vAlign should be 'center'")
        #expect( stackModel.layout.margin.topMargin == .zero, "Margin topMargin should be 'zero'")
        #expect( stackModel.layout.margin.bottomMargin == VSpacing.xs.rawValue, "Margin bottomMargin should be 'xs'")
        #expect( stackModel.layout.margin.leftMargin == HSpacing.m.rawValue, "Margin leftMargin should be 'm'")
        #expect( stackModel.layout.margin.rightMargin == HSpacing.l.rawValue, "Margin rightMargin should be 'l'")
        
        #expect( stackModel.layout.padding.hPadding == HSpacing.m.rawValue, "Padding hPadding should be 'm'")
        #expect( stackModel.layout.padding.vPadding == VSpacing.s.rawValue, "Padding vPadding should be 's'")
        
        
        
        #expect( stackModel.items.count==3, "Items count should be 3")
        
        #expect( stackModel.items[0].identifier == "my_activityIndicator", "First item identifier should be 'my_activityIndicator'")
        #expect( stackModel.items[1].identifier == "my_spacer", "Second item identifier should be 'my_spacer'")
        #expect( stackModel.items[2].identifier == "button", "Third item identifier should be 'button'")
        
        guard let buttonViewModel =  stackModel.items[2] as? DSButtonViewModel else {
            #expect(false, "Third item identifier should be 'DSButtonViewModel")
            return
        }
        #expect(didPerformAction == false, "Action should not be performed")
        buttonViewModel.onTap?()
        #expect(didPerformAction == true, "Action should be performed")
        
        guard let labelModel = viewModel.valueLabel as? DSLabelViewModel else {
            #expect(false, "my_view is not a DSLabelViewModel")
            return
        }
        
        #expect(labelModel.text == "Привет!!!!", "Title should be 'Привет!!!!'")
        #expect(labelModel.style == .beautyful, "Style should be 'beautyful'")
        #expect(labelModel.size == .l, "Size should be 'l'")
        #expect(labelModel.state == .hidden, "State should be 'hidden'")
        
        #expect(labelModel.layout.margin.width == .auto, "Margin width should be 'auto'")
        #expect(labelModel.layout.margin.height == .fixed(50), "Margin height should be 'fixed(50)'")
        #expect(labelModel.layout.margin.hAlign == .auto, "Margin hAlign should be 'auto'")
        #expect(labelModel.layout.margin.vAlign == .center, "Margin vAlign should be 'center'")
        #expect(labelModel.layout.margin.topMargin == .zero, "Margin topMargin should be 'zero'")
        #expect(labelModel.layout.margin.bottomMargin == VSpacing.xs.rawValue, "Margin bottomMargin should be 'xs'")
        #expect(labelModel.layout.margin.leftMargin == HSpacing.m.rawValue, "Margin leftMargin should be 'm'")
        #expect(labelModel.layout.margin.rightMargin == HSpacing.l.rawValue, "Margin rightMargin should be 'l'")
        
        #expect(labelModel.layout.padding.hPadding == HSpacing.m.rawValue, "Padding hPadding should be 'm'")
        #expect(labelModel.layout.padding.vPadding == VSpacing.s.rawValue, "Padding vPadding should be 's'")
        
    }

}

