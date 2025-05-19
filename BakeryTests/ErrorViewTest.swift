//
//  ErrorViewTest.swift
//  Bakery
//
//  Created by Елизавета Кравченкова   on 19.05.2025.
//

import Testing
@testable import Bakery

struct ErrorViewTest {

    @Test
    func testJsonMapperImpl() {
        let json = """
        {
            "componentType": "errorView",
            "identifier": "my-errorView",
            "state": "hidden",
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
            "title": {
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
            "button":{
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
                "handler_name": "refresh"
            }
        }
        }
        """.data(using: .utf8)!

        var performAction = false
        ActionHandler<Void>.shared().registerHandler(for: HandlerModel(custom: "refresh"), handler: {string in
            performAction = true
        })
        
        var (my_view, _) = JsonMapperImpl.map(jsonData: json)
        
        guard let viewModel = my_view as? ErrorViewModel else {
            #expect(false, "my_view is not a ErrorViewModel")
            return
        }
        
        #expect(viewModel.identifier == "my-errorView", "identifier should be 'my-errorView'")
        #expect(viewModel.style == .primary, "Style should be 'placeholder'")

        #expect(viewModel.state == .hidden, "State should be 'error'")
        
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
        
        
        guard let labelModel = viewModel.title else {
            #expect(false, "my_view is not have a labelModel")
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
    
    
    
        guard let buttonViewModel = viewModel.refreshButton else {
            #expect(false, "my_view is not have a refreshButton")
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
        
        #expect(performAction==false, "Action should not be performed")
        viewModel.refreshButton?.onTap?()
        #expect(performAction == true, "Action should be performed")
        
}

}
