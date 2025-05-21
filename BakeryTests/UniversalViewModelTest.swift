//
//  UniversalViewModelTest.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 21.05.2025.
//

import Testing
@testable import Bakery
import Foundation
import UIKit

struct UniversalViewModelTest {

    @Test
    func testJsonEncode() throws {
        let json = """
        {
            "style": "primary",
            "components": [
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
                        "handler_name": "printerStack"
                    }
                }
            ]
        }
        """.data(using: .utf8)!
        
        var didPerformAction = false
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(custom: "printerStack"), handler: {
            didPerformAction = true
        })
        
        let decoder = JSONDecoder()
        let viewModel = try decoder.decode(UniversalViewModel.self, from: json)
        

        #expect(viewModel.style == .primary, "style should be 'primary'")

        #expect(viewModel.components.count==3, "Items count should be 3")
        
        #expect(viewModel.components[0].identifier == "my_activityIndicator", "First item identifier should be 'my_activityIndicator'")
        #expect(viewModel.components[1].identifier == "my_spacer", "Second item identifier should be 'my_spacer'")
        #expect(viewModel.components[2].identifier == "button", "Third item identifier should be 'button'")
        
        guard let buttonViewModel = viewModel.components[2] as? DSButtonViewModel else {
            #expect(false, "Third item identifier should be 'DSButtonViewModel")
            return
        }
        #expect(didPerformAction == false, "Action should not be performed")
        buttonViewModel.onTap?()
        #expect(didPerformAction == true, "Action should be performed")
    }
    
    
    
    
    @Test
    func testSomeScreenJsonEncode() throws {
        let transfer_image: UIImage = .logo
        let data = transfer_image.toBase64() ?? ""
        
        let json = """
        {
                    "style": "primary",
                    "components": [
                        {
                            "componentType": "image",
                            "identifier": "logo",
                            "size": "default",
                            "imageBase64": "\(data)",
                            "layout": {
                                "margin": {
                                    "hAlign": "center",
                                    "topMargin": "l"
                                }
                            }
                        },
                        {
                            "componentType": "text",
                            "identifier": "id-field",
                            "placeholder": "введите название продукта",
                            "size": "medium",
                            "state": "error",
                            "style": "placeholder",
                            "layout": {
                                "margin": {
                                    "width": "fill",
                                    "topMargin": "l",
                                    "HMargin": "m"
                                },
                                "padding": {
                                    "hPadding": "m",
                                    "vPadding": "s"
                                }
                            }
                        },
                        {
                            "componentType": "button",
                            "identifier": "refresh-button",
                            "title": "Обновить",
                            "style": "primary",
                            "size": "medium",
                            "state": "default",
                            "layout": {
                                "margin": {
                                    "hAlign": "center",
                                    "topMargin": "xl"
                                },
                                "padding": {
                                    "hPadding": "m",
                                    "vPadding": "xs"
                                }
                            },
                            "action": {
                                "type": "custom",
                                "handler_name": "some-screen/refresh"
                            }
                        },
                        {
                            "componentType": "button",
                            "identifier": "route-button",
                            "title": "Вернуться",
                            "style": "primary",
                            "size": "medium",
                            "state": "default",
                            "layout": {
                                "margin": {
                                    "hAlign": "center",
                                    "topMargin": "m"
                                },
                                "padding": {
                                    "hPadding": "m",
                                    "vPadding": "xs"
                                }
                            },
                            "action": {
                                "type": "route",
                                "target": "home"
                            }
                        },
                        {
                            "componentType": "activityIndicator",
                            "identifier": "my_activityIndicator",
                            "style": "primary",
                            "size": "large",
                            "state": "stopped",
                            "layout": {
                                "margin": {
                                    "hAlign": "center",
                                    "vAlign": "center"
                                }
                            }
                        },
                        {
                            "componentType": "spacer",
                            "identifier": "my_spacer",
                            "minHeight": 20,
                            "layout": {
                                "margin": {
                                    "width": "fill",
                                    "topMargin": "zero",
                                    "bottomMargin": "zero",
                                    "HMargin": "m"
                                }
                            }
                        }
                    ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let viewModel = try decoder.decode(UniversalViewModel.self, from: json)
        

        #expect(viewModel.style == .primary, "style should be 'primary'")

        #expect(viewModel.components.count==6, "Items count should be 3")
        
        #expect(viewModel.components[1].identifier == "id-field", "First item identifier should be 'id-field'")
        
        #expect(viewModel.components[4].identifier == "my_activityIndicator", "First item identifier should be 'my_activityIndicator'")
        #expect(viewModel.components[5].identifier == "my_spacer", "Four item identifier should be 'my_spacer'")
        #expect(viewModel.components[2].identifier == "refresh-button", "Third item identifier should be 'refresh-button'")
        #expect(viewModel.components[3].identifier == "route-button", "Third item identifier should be 'route-button'")
    }

}
