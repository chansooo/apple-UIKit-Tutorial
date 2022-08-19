//
//  UIView+PinnedSubview.swift
//  preview
//
//  Created by kimchansoo on 2022/08/18.
//

import UIKit

extension UIView {
    func addPinnedSubview(_ subView: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right).isActive = true
        subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom
        ).isActive = true
        if let height = height {
            subView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
