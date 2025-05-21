//
//  CommonCardTest.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Testing
@testable import Bakery
import UIKit

struct CommonCardTest {

    @Test
    func testJsonMapperImpl() {
        let transfer_image: UIImage = .points
        let data = transfer_image.toBase64() ?? ""
        
        let json = """
        {
            "componentType": "commonCard",
            "identifier": "my-commonCard",
            "size": "medium",
            "style": "image",
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
                "handler_name": "printerCommonCard"
            },
            "backroundImage": "\(data)",
            "content": 
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
                            "handler_name": "printerContainerInCommonCard"
                        }
                    }
                ]
            }
        }
        """.data(using: .utf8)!

        var performAction1 = false
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(custom: "printerCommonCard"), handler: {
            performAction1 = true
        })
        
        var performAction2 = false
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(custom: "printerContainerInCommonCard"), handler: {
            performAction2 = true
        })
        
        var (my_view, _) = JsonMapperImpl.map(jsonData: json)
        
        guard let viewModel = my_view as? CommonCardViewModel else {
            #expect(false, "my_view is not a CommonCardViewModel")
            return
        }
        
        #expect(viewModel.identifier == "my-commonCard", "identifier should be 'my-commonCard'")
        #expect(viewModel.backroundImageView?.pngData() == transfer_image.pngData(), "Image should be equal")
        
        #expect(viewModel.style == .image, "Style should be 'image'")
        #expect(viewModel.size == .medium, "Size should be 'medium'")
       
        
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
        
        
        #expect(performAction1 == false, "Action should not be performed")
        viewModel.onTap?()
        #expect(performAction1 == true, "Action should be performed")
        
        guard let vm = viewModel.content as? DSContainerViewModel else {
            #expect(false, "my_view is not have a DSContainerViewModel")
            return
        }

        #expect(vm.identifier == "my-container", "id should be 'my-container'")
        #expect(vm.topView == 0, "topView should be '0'")
        #expect(vm.bottomView == 2, "bottomView should be '2'")
        
        #expect(vm.layout.margin.width == .auto, "Margin width should be 'auto'")
        #expect(vm.layout.margin.height == .fixed(50), "Margin height should be 'fixed(50)'")
        #expect(vm.layout.margin.hAlign == .auto, "Margin hAlign should be 'auto'")
        #expect(vm.layout.margin.vAlign == .center, "Margin vAlign should be 'center'")
        #expect(vm.layout.margin.topMargin == .zero, "Margin topMargin should be 'zero'")
        #expect(vm.layout.margin.bottomMargin == VSpacing.xs.rawValue, "Margin bottomMargin should be 'xs'")
        #expect(vm.layout.margin.leftMargin == HSpacing.m.rawValue, "Margin leftMargin should be 'm'")
        #expect(vm.layout.margin.rightMargin == HSpacing.l.rawValue, "Margin rightMargin should be 'l'")
        
        #expect(vm.layout.padding.hPadding == HSpacing.m.rawValue, "Padding hPadding should be 'm'")
        #expect(vm.layout.padding.vPadding == VSpacing.s.rawValue, "Padding vPadding should be 's'")
        
        
        
        #expect(vm.items.count==3, "Items count should be 3")
        
        #expect(vm.items[0].identifier == "my_activityIndicator", "First item identifier should be 'my_activityIndicator'")
        #expect(vm.items[1].identifier == "my_spacer", "Second item identifier should be 'my_spacer'")
        #expect(vm.items[2].identifier == "button", "Third item identifier should be 'button'")
        
        guard let buttonViewModel = vm.items[2] as? DSButtonViewModel else {
            #expect(false, "Third item identifier should be 'DSButtonViewModel")
            return
        }
        #expect(performAction2 == false, "Action should not be performed")
        buttonViewModel.onTap?()
        #expect(performAction2 == true, "Action should be performed")
    }

}
