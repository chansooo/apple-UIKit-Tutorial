//
//  TextFieldContentView.swift
//  Today
//
//  Created by Gordon Choi on 2022/08/18.
//

import UIKit

final class TextFieldContentView: UIView, UIContentView {
    struct configuration: UIContentConfiguration {
        var text: String? = ""
        
        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
    }
    
    let textField = UITextField()
    var configuration: UIContentConfiguration
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        
        super.init(frame: .zero)
        
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textField.clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
